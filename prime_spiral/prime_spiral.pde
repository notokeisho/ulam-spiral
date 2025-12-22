// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// === Global variables ===

// Prime number array
int[] primes;

// Maximum integer to display
int N = 1000000;

// Time management
int lastMillis;
float dt;  // Delta time in seconds (global for event handlers)

// Mouse position tracking
float prevMouseX, prevMouseY;
boolean isFirstDrag = true;  // Flag for first drag detection

// === Setup ===
void setup() {
  size(1024, 1024);

  // Initialize time
  lastMillis = millis();

  // Generate prime numbers
  generatePrimes(N);

  // Set spiral scale (rMax = half of width)
  setScale(width / 2, N);

  // Set max radius for gradient effect
  maxRadius = width / 2;

  // Note: prevMouseX/Y are not initialized here
  // They will be set on first drag using isFirstDrag flag

  println("Prime Spiral initialized");
  println("Number of primes: " + primes.length);
  println("Spiral scale: " + spiralScale);
}

// === Draw loop ===
void draw() {
  // Calculate delta time
  int currentMillis = millis();
  dt = (currentMillis - lastMillis) / 1000.0;
  lastMillis = currentMillis;

  // Decay heat over time
  decayHeat(dt);

  // Draw background (before translate)
  drawBackground();

  // Set up coordinate system: origin at center
  translate(width / 2, height / 2);

  // Apply zoom
  scale(currentZoom);

  // Draw each prime number
  for (int i = 0; i < primes.length; i++) {
    int prime = primes[i];

    // Calculate base position on spiral
    PVector p0 = calculateBasePosition(prime);

    // Apply twist transformation
    PVector p1 = applyTwist(p0, twistCount);

    // Convert to screen coordinates (for distance calculation)
    PVector screenPos = worldToScreen(p1);

    // Apply noise warp based on heat and mouse position
    PVector p = applyNoiseWarp(p1, screenPos.x, screenPos.y, mouseX, mouseY, heat);

    // Draw the point
    drawPoint(p);
  }
}

// === Event handlers ===

// Handle mouse drag event
void mouseDragged() {
  if (mouseButton == LEFT) {
    // First drag: initialize previous mouse position
    if (isFirstDrag) {
      prevMouseX = mouseX;
      prevMouseY = mouseY;
      isFirstDrag = false;
      return;
    }

    // Calculate velocity and update heat
    float velocity = calculateVelocity(dt);
    updateHeat(velocity, dt);

    // Update previous mouse position
    prevMouseX = mouseX;
    prevMouseY = mouseY;
  }
}

// Handle mouse press event
void mousePressed() {
  if (mouseButton == CENTER) {
    addTwist();
  }
}

// Handle mouse wheel event
void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  handleMouseWheel(delta);
}

// Handle key press event
void keyPressed() {
  if (key == ' ') {
    use3Blue1Brown = !use3Blue1Brown;
  }
  if (key == 'r' || key == 'R') {
    // Reset state (except zoom)
    twistCount = 0;
    heat = 0.0;
    use3Blue1Brown = true;
  }
}
