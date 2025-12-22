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
// Uses 3Blue1Brown style: theta = n radians, r = scale * sqrt(n)
PVector calculateBasePosition(int n) {
  float theta = n;  // n radians (3Blue1Brown style)
  float r = spiralScale * sqrt(n);

  float x = r * cos(theta);
  float y = r * sin(theta);

  return new PVector(x, y);
}
