/* The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 */

public class ten {

    public static void main(String[] aArgs) {

    	long startTime = System.nanoTime();   
        int maxValue = 2000000;
        long sum = 0;

        for (int i = 0; i < maxValue; i++) {
        	if (isPrime(i)) sum += i;
        }

        long elapsedTime = System.nanoTime() - startTime;
        System.out.println("The answer is " + sum + " and it took " + elapsedTime / 1000000000 + " seconds");
    }

	static boolean isPrime(int number) {
        boolean isPrime = true;

		for (int i = 2; i*i <number  +1 ; i++) {
			if (number % i == 0) {
				isPrime = false;
			}
		}

		if (number == 2 || number == 3 || number == 5) {
			isPrime = true;
		}

		if (number == 1) {
			isPrime = false;
		}
		return isPrime;
	}
}