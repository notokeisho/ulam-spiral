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
