// InputHandler.pde - Input handling module
// Handles mouse input, zoom, and coordinate conversion

// Zoom constants
final float MIN_ZOOM = 0.1;
final float MAX_ZOOM = 10.0;
final float ZOOM_STEP = 1.15;

// Zoom state
float currentZoom = 1.0;

// Calculate mouse velocity from previous position
// Returns velocity magnitude in pixels per second
float calculateVelocity(float dt) {
  if (dt <= 0) return 0;

  float dx = mouseX - prevMouseX;
  float dy = mouseY - prevMouseY;
  float distance = sqrt(dx * dx + dy * dy);

  return distance / dt;
}

// Handle mouse drag event
// Note: updateHeat() call will be added after Task 4.2
void handleMouseDragged(float dt) {
  float velocity = calculateVelocity(dt);

  // Update previous mouse position
  prevMouseX = mouseX;
  prevMouseY = mouseY;
}

// Handle mouse wheel event for zooming
void handleMouseWheel(float delta) {
  if (delta < 0) {
    // Zoom in
    currentZoom *= ZOOM_STEP;
  } else {
    // Zoom out
    currentZoom /= ZOOM_STEP;
  }

  // Clamp zoom to valid range
  currentZoom = constrain(currentZoom, MIN_ZOOM, MAX_ZOOM);
}

// Convert world coordinates to screen coordinates
PVector worldToScreen(PVector world) {
  float screenX = world.x * currentZoom + width / 2;
  float screenY = world.y * currentZoom + height / 2;

  return new PVector(screenX, screenY);
}
