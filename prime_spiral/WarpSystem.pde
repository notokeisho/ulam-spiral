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
