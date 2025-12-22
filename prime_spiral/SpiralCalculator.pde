// SpiralCalculator.pde - Spiral coordinate calculation module
// Calculates positions on the Archimedean spiral

// Scale coefficient for the spiral
float spiralScale;

// Set the scale coefficient
// rMax: maximum radius (typically width/2)
// N: maximum integer to display
void setScale(float rMax, int N) {
  spiralScale = rMax / sqrt(N);
}

// Calculate the base position for integer n on the spiral
// Returns: PVector with (x, y) coordinates
PVector calculateBasePosition(int n) {
  float t = sqrt(n);
  float theta = TWO_PI * t;
  float r = spiralScale * t;

  float x = r * cos(theta);
  float y = r * sin(theta);

  return new PVector(x, y);
}
