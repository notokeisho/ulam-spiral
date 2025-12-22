// prime_spiral.pde - Main entry point
// Entry point for the Prime Spiral application

// Global variables
int[] primes;
float prevMouseX, prevMouseY;

// Temporary test code for Task 4.3
void setup() {
  size(400, 400);

  // === Task 4.3: Warp Transformation Test ===
  println("=== Task 4.3: Warp Transformation Test ===");
  println();

  // Test 1: applyTwist with twistCount = 0
  println("Test 1: applyTwist with twistCount = 0");
  PVector pos1 = new PVector(100, 0);
  PVector result1 = applyTwist(pos1, 0);
  println("Input: (" + pos1.x + ", " + pos1.y + ")");
  println("Output: (" + result1.x + ", " + result1.y + ")");
  println("Expected: same as input (no twist)");
  println();

  // Test 2: applyTwist with twistCount = 1
  println("Test 2: applyTwist with twistCount = 1");
  PVector pos2 = new PVector(100, 0);  // distance = 100
  PVector result2 = applyTwist(pos2, 1);
  float expectedRotation = TWIST_STRENGTH * 100 * 1;  // 0.1 * 100 * 1 = 10 radians
  println("Input: (" + pos2.x + ", " + pos2.y + "), distance = 100");
  println("Output: (" + nf(result2.x, 1, 3) + ", " + nf(result2.y, 1, 3) + ")");
  println("Rotation: " + expectedRotation + " radians");
  println("Expected: rotated position");
  println();

  // Test 3: applyTwist - verify rotation formula
  println("Test 3: applyTwist - verify rotation formula");
  PVector pos3 = new PVector(50, 0);  // distance = 50
  PVector result3 = applyTwist(pos3, 2);
  float rotation3 = TWIST_STRENGTH * 50 * 2;  // 0.1 * 50 * 2 = 10 radians
  float expectedX = 50 * cos(rotation3) - 0 * sin(rotation3);
  float expectedY = 50 * sin(rotation3) + 0 * cos(rotation3);
  println("Input: (" + pos3.x + ", " + pos3.y + ")");
  println("Output: (" + nf(result3.x, 1, 3) + ", " + nf(result3.y, 1, 3) + ")");
  println("Expected: (" + nf(expectedX, 1, 3) + ", " + nf(expectedY, 1, 3) + ")");
  println("Match: " + (abs(result3.x - expectedX) < 0.001 && abs(result3.y - expectedY) < 0.001 ? "OK" : "NG"));
  println();

  // Test 4: addTwist
  println("Test 4: addTwist");
  println("Initial twistCount: " + twistCount);
  addTwist();
  println("After addTwist(): " + twistCount);
  addTwist();
  println("After addTwist(): " + twistCount);
  println("Expected: 0 -> 1 -> 2");
  twistCount = 0;  // Reset for next tests
  println();

  // Test 5: applyNoiseWarp with heat = 0
  println("Test 5: applyNoiseWarp with heat = 0");
  PVector pos5 = new PVector(100, 50);
  PVector result5 = applyNoiseWarp(pos5, 200, 200, 200, 200, 0);
  println("Input: (" + pos5.x + ", " + pos5.y + "), heat = 0");
  println("Output: (" + result5.x + ", " + result5.y + ")");
  println("Expected: same as input (no warp when heat = 0)");
  println();

  // Test 6: applyNoiseWarp with heat = 1.0, mouse at same position
  println("Test 6: applyNoiseWarp with heat = 1.0, mouse at point");
  PVector pos6 = new PVector(100, 50);
  // Screen position at (300, 250), mouse at same position
  PVector result6 = applyNoiseWarp(pos6, 300, 250, 300, 250, 1.0);
  float dist6 = dist(300, 250, 300, 250);  // 0
  float influence6 = exp(-dist6 * dist6 / (2 * SIGMA * SIGMA));  // 1.0
  float maxDisp6 = MAX_DISPLACEMENT * 1.0 * influence6;  // 30.0
  println("Input: (" + pos6.x + ", " + pos6.y + ")");
  println("Screen dist from mouse: " + dist6);
  println("Influence (Gaussian): " + influence6);
  println("Max possible displacement: " + maxDisp6);
  println("Output: (" + nf(result6.x, 1, 3) + ", " + nf(result6.y, 1, 3) + ")");
  println("Expected: displaced by up to " + maxDisp6 + " pixels");
  println();

  // Test 7: applyNoiseWarp with distance from mouse
  println("Test 7: applyNoiseWarp with distance from mouse");
  PVector pos7 = new PVector(100, 50);
  // Screen position at (300, 250), mouse at (350, 250) -> distance = 50
  PVector result7 = applyNoiseWarp(pos7, 300, 250, 350, 250, 1.0);
  float dist7 = dist(300, 250, 350, 250);  // 50
  float influence7 = exp(-dist7 * dist7 / (2 * SIGMA * SIGMA));
  float maxDisp7 = MAX_DISPLACEMENT * 1.0 * influence7;
  println("Input: (" + pos7.x + ", " + pos7.y + ")");
  println("Screen dist from mouse: " + dist7);
  println("Influence (Gaussian): " + nf(influence7, 1, 4));
  println("Max possible displacement: " + nf(maxDisp7, 1, 3));
  println("Output: (" + nf(result7.x, 1, 3) + ", " + nf(result7.y, 1, 3) + ")");
  println("Expected: less displacement than Test 6 due to distance");
  println();

  // Test 8: Verify Gaussian attenuation at SIGMA distance
  println("Test 8: Gaussian attenuation at SIGMA distance");
  float distAtSigma = SIGMA;  // 50
  float influenceAtSigma = exp(-distAtSigma * distAtSigma / (2 * SIGMA * SIGMA));
  println("Distance = SIGMA = " + SIGMA);
  println("Influence = " + nf(influenceAtSigma, 1, 4));
  println("Expected: e^(-0.5) = " + nf(exp(-0.5), 1, 4));
  println();

  println("=== End of Test ===");
}

void draw() {
  background(0);
}
