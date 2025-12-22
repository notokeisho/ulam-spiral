// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// Global variables
int[] primes;
float prevMouseX, prevMouseY;

// Temporary test code for Task 3.1
void setup() {
  size(400, 400);

  // === Task 3.1: InputHandler Test ===
  println("=== Task 3.1: InputHandler Test ===");
  println();

  // Test 1: Zoom constants and initial value
  println("Test 1: Zoom constants");
  println("MIN_ZOOM = " + MIN_ZOOM + " (expected: 0.1)");
  println("MAX_ZOOM = " + MAX_ZOOM + " (expected: 10.0)");
  println("ZOOM_STEP = " + ZOOM_STEP + " (expected: 1.15)");
  println("currentZoom = " + currentZoom + " (expected: 1.0)");
  println();

  // Test 2: handleMouseWheel - zoom in
  println("Test 2: Zoom in (negative delta)");
  float beforeZoom = currentZoom;
  handleMouseWheel(-1);
  println("Before: " + beforeZoom + " -> After: " + currentZoom);
  println("Expected: " + (beforeZoom * ZOOM_STEP));
  println();

  // Test 3: handleMouseWheel - zoom out
  println("Test 3: Zoom out (positive delta)");
  beforeZoom = currentZoom;
  handleMouseWheel(1);
  println("Before: " + beforeZoom + " -> After: " + currentZoom);
  println("Expected: " + (beforeZoom / ZOOM_STEP));
  println();

  // Test 4: Zoom clamping - try to exceed MAX_ZOOM
  println("Test 4: Zoom clamping (MAX_ZOOM)");
  currentZoom = 9.5;
  handleMouseWheel(-1);
  println("After zoom in from 9.5: " + currentZoom);
  println("Expected: clamped to " + MAX_ZOOM);
  println();

  // Test 5: Zoom clamping - try to go below MIN_ZOOM
  println("Test 5: Zoom clamping (MIN_ZOOM)");
  currentZoom = 0.15;
  handleMouseWheel(1);
  println("After zoom out from 0.15: " + currentZoom);
  println("Expected: clamped to " + MIN_ZOOM);
  println();

  // Reset zoom for next tests
  currentZoom = 1.0;

  // Test 6: worldToScreen conversion
  println("Test 6: worldToScreen conversion");
  PVector worldPos = new PVector(100, 50);
  PVector screenPos = worldToScreen(worldPos);
  println("World: (" + worldPos.x + ", " + worldPos.y + ")");
  println("Screen: (" + screenPos.x + ", " + screenPos.y + ")");
  println("Expected: (" + (100 * 1.0 + 200) + ", " + (50 * 1.0 + 200) + ")");
  println();

  // Test 7: worldToScreen with zoom
  println("Test 7: worldToScreen with zoom = 2.0");
  currentZoom = 2.0;
  screenPos = worldToScreen(worldPos);
  println("World: (" + worldPos.x + ", " + worldPos.y + ")");
  println("Screen: (" + screenPos.x + ", " + screenPos.y + ")");
  println("Expected: (" + (100 * 2.0 + 200) + ", " + (50 * 2.0 + 200) + ")");
  println();

  // Test 8: calculateVelocity
  println("Test 8: calculateVelocity");
  prevMouseX = 0;
  prevMouseY = 0;
  // Simulate mouse at (30, 40) - distance should be 50
  // Note: Can't directly test without actual mouse, but function is ready
  println("Function implemented. Will be tested during mouse interaction.");
  println();

  println("=== End of Test ===");
}

void draw() {
  background(0);
}
