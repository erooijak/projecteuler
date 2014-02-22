import java.util.ArrayList;

public class seven {
	public static void main(String[] aArgs) {
 		System.out.println("The answer is: " + get10001stPrime());
	}

	static long get10001stPrime() {

         long i = 0;
         long counter = 0;
         boolean isFound = false;

         while (isFound == false) {
         	 i++;
     		 if (isPrime(i)) {
     		 	

     		 	if (counter == 10001) {
     		 		isFound = true;
     		 	}
     		 	counter++;
     		 }
     		 
         }
         return i;
	}

	static boolean isPrime(long number) {
        boolean isPrime = true;

		for (long i = 2; i*i <number  +1 ; i++) {
			if (number % i == 0) {
				isPrime = false;
			}
		}

		if (number == 2 || number == 3 || number == 5) {
			isPrime = true;
		}
		return isPrime;
	}
}