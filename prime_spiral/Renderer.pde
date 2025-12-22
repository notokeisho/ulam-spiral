// Renderer.pde - Rendering module
// Handles drawing background and prime points

// Color and size constants
color BG_COLOR = color(0);           // Black background
color CENTER_COLOR = color(0, 255, 255);  // Bright cyan at center
color EDGE_COLOR = color(200, 200, 220);  // Light grayish-white at edges
float POINT_SIZE = 1.0;              // Point diameter (reduced from 1.5)

// Maximum radius for gradient calculation (will be set in setup)
float maxRadius = 512;

// Draw the background
void drawBackground() {
  background(BG_COLOR);
}

// Draw a single point with gradient and glow effect
// pos: position in world coordinates
// distFromCenter: distance from spiral center (0 = center)
void drawPointWithGradient(PVector pos, float distFromCenter) {
  noStroke();

  // Calculate gradient ratio (0 = center, 1 = edge)
  float ratio = constrain(distFromCenter / maxRadius, 0, 1);

  // Interpolate color from center to edge
  float r = lerp(red(CENTER_COLOR), red(EDGE_COLOR), ratio);
  float g = lerp(green(CENTER_COLOR), green(EDGE_COLOR), ratio);
  float b = lerp(blue(CENTER_COLOR), blue(EDGE_COLOR), ratio);

  // Glow effect: increase brightness near center
  float glow = 1.2 + (1.0 - ratio) * 0.8;  // 2.0x at center, 1.2x at edge
  r = constrain(r * glow, 0, 255);
  g = constrain(g * glow, 0, 255);
  b = constrain(b * glow, 0, 255);

  fill(r, g, b);
  ellipse(pos.x, pos.y, POINT_SIZE, POINT_SIZE);
}

// Legacy function for compatibility
void drawPoint(PVector pos) {
  drawPointWithGradient(pos, pos.mag());
}
