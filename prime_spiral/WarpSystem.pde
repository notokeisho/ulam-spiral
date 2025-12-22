// WarpSystem.pde - Warp system module (heat + twist)
// Handles temporary distortion and permanent twist effects

// === State variables ===
float heat = 0.0;    // Current heat level (0.0 = no distortion)
int twistCount = 0;  // Number of twist operations applied

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

// Twist rotation strength per twist count
final float TWIST_STRENGTH = 0.1;

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

// Apply twist rotation based on distance from center
// pos: position in world coordinates
// twistCount: number of twist operations applied
// Returns: new position with twist applied
PVector applyTwist(PVector pos, int twistCount) {
  if (twistCount == 0) {
    return pos.copy();
  }

  float distance = pos.mag();  // Distance from center

  // Rotation amount proportional to distance
  float rotation = TWIST_STRENGTH * distance * twistCount;

  // Apply rotation matrix
  float newX = pos.x * cos(rotation) - pos.y * sin(rotation);
  float newY = pos.x * sin(rotation) + pos.y * cos(rotation);

  return new PVector(newX, newY);
}

// Apply noise-based warp displacement
// pos: position in world coordinates
// screenX, screenY: position in screen coordinates (for distance calculation)
// mX, mY: mouse position in screen coordinates
// h: current heat value
// Returns: new position with noise warp applied
PVector applyNoiseWarp(PVector pos, float screenX, float screenY,
                       float mX, float mY, float h) {
  if (h <= 0) {
    return pos.copy();
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

// Increment twist count (called on right click)
void addTwist() {
  twistCount++;
}
