// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// Global variables
int[] primes;
float prevMouseX, prevMouseY;

// Temporary test code for Task 4.2
void setup() {
  size(400, 400);

  // === Task 4.2: Heat Processing Test ===
  println("=== Task 4.2: Heat Processing Test ===");
  println();

  // Test 1: Initial heat value
  println("Test 1: Initial heat value");
  println("heat = " + heat + " (expected: 0.0)");
  println();

  // Test 2: updateHeat - increase heat
  println("Test 2: updateHeat - increase heat");
  heat = 0.0;
  float velocity = 500.0;  // pixels per second
  float dt = 0.016;        // ~60fps
  println("Before: heat = " + heat);
  println("velocity = " + velocity + ", dt = " + dt);
  updateHeat(velocity, dt);
  println("After: heat = " + heat);
  println("Expected: " + (K_HEAT * velocity * dt) + " (K_HEAT * velocity * dt)");
  println();

  // Test 3: updateHeat - clamping to 1.0
  println("Test 3: updateHeat - clamping to 1.0");
  heat = 0.95;
  println("Before: heat = " + heat);
  updateHeat(1000, 0.1);  // Large velocity to exceed 1.0
  println("After: heat = " + heat);
  println("Expected: 1.0 (clamped)");
  println();

  // Test 4: decayHeat - exponential decay
  println("Test 4: decayHeat - exponential decay");
  heat = 1.0;
  println("Initial heat = " + heat);
  println("TAU_HEAT = " + TAU_HEAT);
  println();

  // Simulate decay over multiple frames
  println("Simulating decay (dt = 0.5s per step):");
  for (int i = 1; i <= 10; i++) {
    decayHeat(0.5);
    println("After " + (i * 0.5) + "s: heat = " + nf(heat, 1, 4));
  }
  println();

  // Test 5: decayHeat - small value cleanup
  println("Test 5: decayHeat - small value cleanup");
  heat = 0.0005;
  println("Before: heat = " + heat);
  decayHeat(0.1);
  println("After: heat = " + heat);
  println("Expected: 0.0 (cleaned up because < 0.001)");
  println();

  // Test 6: Verify decay formula
  println("Test 6: Verify decay formula");
  heat = 1.0;
  float expectedAfterTau = exp(-1);  // After TAU_HEAT seconds, should be ~0.368
  decayHeat(TAU_HEAT);
  println("After TAU_HEAT seconds: heat = " + heat);
  println("Expected (e^-1): " + expectedAfterTau);
  println();

  println("=== End of Test ===");
}

void draw() {
  background(0);
}
