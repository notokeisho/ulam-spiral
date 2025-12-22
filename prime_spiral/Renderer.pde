// Renderer.pde - Rendering module
// Handles drawing background and prime points

// Color and size constants
color BG_COLOR = color(0);           // Black background
color POINT_COLOR = color(0, 200, 255);  // Cyan points
float POINT_SIZE = 1.5;              // Point diameter

// Draw the background
void drawBackground() {
  background(BG_COLOR);
}

// Draw a single point at the given position
void drawPoint(PVector pos) {
  noStroke();
  fill(POINT_COLOR);
  ellipse(pos.x, pos.y, POINT_SIZE, POINT_SIZE);
}
