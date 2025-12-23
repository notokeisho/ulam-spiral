// PrimeGenerator.pde - Prime number generation module
// Generates prime numbers using the Sieve of Eratosthenes

void generatePrimes(int max) {
  // Sieve of Eratosthenes algorithm
  boolean[] sieve = new boolean[max + 1];

  // Initialize: assume all numbers are prime
  for (int i = 0; i <= max; i++) {
    sieve[i] = true;
  }

  // 0 and 1 are not prime
  sieve[0] = false;
  sieve[1] = false;

  // Mark non-primes
  for (int i = 2; i * i <= max; i++) {
    if (sieve[i]) {
      for (int j = i * i; j <= max; j += i) {
        sieve[j] = false;
      }
    }
  }

  // Count primes
  int count = 0;
  for (int i = 2; i <= max; i++) {
    if (sieve[i]) {
      count++;
    }
  }

  // Allocate primes array and fill
  primes = new int[count];
  int index = 0;
  for (int i = 2; i <= max; i++) {
    if (sieve[i]) {
      primes[index] = i;
      index++;
    }
  }
}
