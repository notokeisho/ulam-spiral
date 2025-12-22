// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// === Global variables ===

// Prime number array
int[] primes;

// Maximum integer to display
int N = 50000;

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

  // Note: prevMouseX/Y are not initialized here
  // They will be set on first drag using isFirstDrag flag

  println("Prime Spiral initialized");
  println("Number of primes: " + primes.length);
  println("Spiral scale: " + spiralScale);
}

// === Draw loop ===
void draw() {
  // Placeholder - will be implemented in Task 5.2
  background(0);
}
