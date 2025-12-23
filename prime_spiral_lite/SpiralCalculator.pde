// SpiralCalculator.pde - Spiral coordinate calculation module
// Calculates positions on the Archimedean spiral

// Scale coefficient for the spiral
float spiralScale;

// Spiral mode: true = 3Blue1Brown style, false = Archimedean style
boolean use3Blue1Brown = true;

// Set the scale coefficient
// Fixed scale for consistent point spacing regardless of N
void setScale(float rMax, int N) {
  spiralScale = 1.0;  // Fixed scale (points don't get cramped as N increases)
}

// Calculate the base position for integer n on the spiral
// Returns: PVector with (x, y) coordinates
// Supports two modes: 3Blue1Brown style and Archimedean style
PVector calculateBasePosition(int n) {
  float theta, r;

  if (use3Blue1Brown) {
    // 3Blue1Brown style: theta = n radians
    theta = n;
    r = spiralScale * sqrt(n);
  } else {
    // Archimedean style: theta = 2π × √n
    float t = sqrt(n);
    theta = TWO_PI * t;
    r = spiralScale * t;
  }

  float x = r * cos(theta);
  float y = r * sin(theta);

  return new PVector(x, y);
}
