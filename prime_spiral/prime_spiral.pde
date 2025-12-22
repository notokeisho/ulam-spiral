// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// Global variables
int[] primes;

// Temporary test code for Task 2.1 and 2.2
void setup() {
  size(400, 400);

  // === Task 2.1: PrimeGenerator Test ===
  println("=== Task 2.1: PrimeGenerator Test ===");
  generatePrimes(100);
  println("Number of primes up to 100: " + primes.length);
  println("Expected: 25 primes");
  println("Result: " + (primes.length == 25 ? "OK" : "NG"));
  println();

  // === Task 2.2: SpiralCalculator Test ===
  println("=== Task 2.2: SpiralCalculator Test ===");

  // Set scale: rMax = 200 (half of 400), N = 100
  setScale(200, 100);
  println("spiralScale = " + spiralScale);
  println("Expected: 200 / sqrt(100) = 20.0");
  println();

  // Calculate positions for n = 1 to 10
  println("Positions for n = 1 to 10:");
  println("n\tt\ttheta\t\tx\t\ty");
  println("---------------------------------------------------");

  for (int n = 1; n <= 10; n++) {
    PVector pos = calculateBasePosition(n);
    float t = sqrt(n);
    float theta = TWO_PI * t;

    // Format output
    println(n + "\t" +
            nf(t, 1, 3) + "\t" +
            nf(theta, 1, 3) + "\t\t" +
            nf(pos.x, 1, 3) + "\t\t" +
            nf(pos.y, 1, 3));
  }

  println();
  println("=== End of Test ===");
}

void draw() {
  background(0);
}
