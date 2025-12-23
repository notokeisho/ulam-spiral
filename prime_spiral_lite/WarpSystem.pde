// WarpSystem.pde - Warp system module (heat + explosion)
// Handles temporary distortion and explosion effects

// === State variables ===
float heat = 0.0;    // Current heat level (0.0 = no distortion)

// === Constants ===
// Heat decay time constant (seconds)
final float TAU_HEAT = 3.5;

// Heat increase coefficient per velocity
final float K_HEAT = 0.002;

// Maximum displacement in pixels when heat = 1.0
final float MAX_DISPLACEMENT = 30.0;

// Gaussian attenuation sigma (pixels from mouse)
final float SIGMA = 50.0;

// Perlin noise scale for warp direction
final float NOISE_SCALE = 0.03;

// === Heat processing functions ===

// Update heat based on mouse velocity
// velocity: mouse speed in pixels per second
// dt: delta time in seconds
void updateHeat(float velocity, float dt) {
  heat += K_HEAT * velocity * dt;

  // Clamp heat to maximum of 1.0
  heat = constrain(heat, 0.0, 1.0);
}

// Decay heat exponentially over time
// dt: delta time in seconds
void decayHeat(float dt) {
  // Exponential decay: heat = heat * e^(-dt/TAU_HEAT)
  heat *= exp(-dt / TAU_HEAT);

  // Set to zero if very small to avoid floating point issues
  if (heat < 0.001) {
    heat = 0.0;
  }
}

// === Warp transformation functions ===

// Apply noise-based warp displacement
// pos: position in world coordinates
// screenX, screenY: position in screen coordinates (for distance calculation)
// mX, mY: mouse position in screen coordinates
// h: current heat value
// Returns: new position with noise warp applied
PVector applyNoiseWarp(PVector pos, float screenX, float screenY,
                       float mX, float mY, float h) {
  if (h <= 0) {
    return pos.get();
  }

  // Calculate distance from mouse in screen coordinates
  float screenDist = dist(screenX, screenY, mX, mY);

  // Gaussian attenuation based on distance
  float influence = exp(-screenDist * screenDist / (2 * SIGMA * SIGMA));

  // Displacement magnitude
  float displacement = MAX_DISPLACEMENT * h * influence;

  // Use Perlin noise to determine warp direction (static: position only)
  float angle = noise(pos.x * NOISE_SCALE, pos.y * NOISE_SCALE) * TWO_PI;

  // Apply displacement
  float dx = cos(angle) * displacement;
  float dy = sin(angle) * displacement;

  return new PVector(pos.x + dx, pos.y + dy);
}

// === Explosion system ===

// Explosion state constants
final int EXPLOSION_IDLE = 0;
final int EXPLOSION_ACTIVE = 1;
final int EXPLOSION_REPAIRING = 2;

// Explosion parameters
final float EXPLOSION_EXPAND_RATE_NORMAL = 100.0;     // Normal expansion speed
final float EXPLOSION_EXPAND_RATE_FAST = 100000.0;    // Fast expansion speed
float explosionExpandRate = EXPLOSION_EXPAND_RATE_NORMAL;  // Current speed
// Explosion strength range (interpolated based on zoom)
final float EXPLOSION_STRENGTH_MIN = 10.0;           // Strength at max zoom-in
final float EXPLOSION_STRENGTH_MAX = 200.0;          // Strength at max zoom-out
final float EXPLOSION_DECAY_TAU = 3.5;              // Repair decay time constant
final float EXPLOSION_COMPLETE_THRESHOLD = 0.01;   // Repair completion threshold
final float ZOOM_SPEED_EXPONENT = 1.1;                // Zoom-out speed boost exponent

// Explosion state
int explosionState = EXPLOSION_IDLE;

// Explosion data (initialized in initExplosionArrays)
PVector[] explosionVelocity;
PVector[] explosionDisplacement;
boolean[] isExploded;

// Explosion info
PVector explosionCenter;
float explosionTime;
float explosionRadius;

// Initialize explosion arrays (call after generatePrimes)
void initExplosionArrays() {
  explosionVelocity = new PVector[primes.length];
  explosionDisplacement = new PVector[primes.length];
  isExploded = new boolean[primes.length];

  for (int i = 0; i < primes.length; i++) {
    explosionVelocity[i] = new PVector(0, 0);
    explosionDisplacement[i] = new PVector(0, 0);
    isExploded[i] = false;
  }

  explosionCenter = new PVector(0, 0);
  explosionTime = 0;
  explosionRadius = 0;
}

// Start explosion at given screen position
void startExplosion(float x, float y) {
  explosionState = EXPLOSION_ACTIVE;
  // Convert screen coordinates to world coordinates (accounting for zoom)
  explosionCenter = new PVector(
    (x - width/2) / currentZoom,
    (y - height/2) / currentZoom
  );
  explosionTime = 0;
  explosionRadius = 0;

  // Reset exploded flags
  for (int i = 0; i < isExploded.length; i++) {
    isExploded[i] = false;
  }
}

// Start explosion repair
void startExplosionRepair() {
  explosionState = EXPLOSION_REPAIRING;
}

// Reset explosion state
void resetExplosion() {
  explosionState = EXPLOSION_IDLE;
  for (int i = 0; i < primes.length; i++) {
    explosionVelocity[i].set(0, 0);
    explosionDisplacement[i].set(0, 0);
    isExploded[i] = false;
  }
  explosionTime = 0;
  explosionRadius = 0;
  explosionExpandRate = EXPLOSION_EXPAND_RATE_NORMAL;
}

// Toggle explosion speed between normal and fast
void toggleExplosionSpeed() {
  if (explosionExpandRate == EXPLOSION_EXPAND_RATE_NORMAL) {
    explosionExpandRate = EXPLOSION_EXPAND_RATE_FAST;
  } else {
    explosionExpandRate = EXPLOSION_EXPAND_RATE_NORMAL;
  }
}

// Update explosion state each frame
void updateExplosion(float dt) {
  if (explosionState == EXPLOSION_IDLE) {
    return;
  }

  if (explosionState == EXPLOSION_ACTIVE) {
    // Update time and radius (speed increases when zoomed out)
    explosionTime += dt;
    explosionRadius = explosionTime * explosionExpandRate * pow(MAX_ZOOM / currentZoom, ZOOM_SPEED_EXPONENT);

    // Update explosion center to mouse position (converted to world coordinates)
    explosionCenter.set(
      (mouseX - width/2) / currentZoom,
      (mouseY - height/2) / currentZoom
    );

    // Process each point
    for (int i = 0; i < primes.length; i++) {
      if (isExploded[i]) {
        // Already exploded: continue moving based on velocity
        explosionDisplacement[i].add(PVector.mult(explosionVelocity[i], dt));
      } else {
        // Not yet exploded: check if within explosion radius
        PVector basePos = calculateBasePosition(primes[i]);
        float dist = PVector.dist(basePos, explosionCenter);

        if (dist < explosionRadius && dist > 0) {
          // Calculate dynamic strength based on zoom level
          float dynamicStrength = map(currentZoom, MIN_ZOOM, MAX_ZOOM, EXPLOSION_STRENGTH_MAX, EXPLOSION_STRENGTH_MIN);

          // Set radial velocity (outward from explosion center)
          PVector direction = PVector.sub(basePos, explosionCenter);
          direction.normalize();
          direction.mult(dynamicStrength * (1.0 - dist / explosionRadius));
          explosionVelocity[i] = direction;
          isExploded[i] = true;
        }
      }
    }
  }

  if (explosionState == EXPLOSION_REPAIRING) {
    // Decay displacement and velocity
    float decay = exp(-dt / EXPLOSION_DECAY_TAU);
    boolean allComplete = true;

    for (int i = 0; i < primes.length; i++) {
      explosionDisplacement[i].mult(decay);
      explosionVelocity[i].mult(decay);

      if (explosionDisplacement[i].mag() > EXPLOSION_COMPLETE_THRESHOLD) {
        allComplete = false;
      }
    }

    // Return to IDLE when all displacements are near zero
    if (allComplete) {
      resetExplosion();
    }
  }
}
