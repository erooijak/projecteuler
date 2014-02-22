/*
 * A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
 * a2 + b2 = c2
 * 
 * For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c = 1000.
 * Find the product abc.
 *
 */

public class nine {
	public static void main(String[] aArgs) {
        
        System.out.println("The answer is: " + findPythogoreanTriplet(1000));
	}

    static int findPythogoreanTriplet(int value) {
    	for (int i = 0; i < value; i++) {
        	for (int j = 0; j < value; j++) {
        		for (int k = 0; k < value; k++) {
        			if (i + j + k == value)
        			{
	        			if (isPythogoreanTriplet(i,j,k)) {
	        				return i*j*k;
	        			}
        			}
        		}
        	}
        }
        return 0;
    }

	static boolean isPythogoreanTriplet(int a, int b, int c) {

		if (a >= b || b >= c) return false;

		if (a*a + b*b == c*c) return true;

		return false;
	}
}
