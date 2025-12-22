// SpiralCalculator.pde - Spiral coordinate calculation module
// Calculates positions on the Archimedean spiral

// Scale coefficient for the spiral
float spiralScale;

// Set the scale coefficient
// Fixed scale for consistent point spacing regardless of N
void setScale(float rMax, int N) {
  spiralScale = 1.0;  // Fixed scale (points don't get cramped as N increases)
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
