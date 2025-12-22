// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// Global variables
int[] primes;

// Temporary test code for Task 2.1
void setup() {
  size(400, 400);

  // Test: generate primes up to 100
  generatePrimes(100);

  // Print results for verification
  println("=== Task 2.1: PrimeGenerator Test ===");
  println("Number of primes up to 100: " + primes.length);
  println("Expected: 25 primes");
  println();
  println("Prime list:");
  for (int i = 0; i < primes.length; i++) {
    print(primes[i] + " ");
    if ((i + 1) % 10 == 0) println();
  }
  println();
  println("=== End of Test ===");
}

void draw() {
  background(0);
}
