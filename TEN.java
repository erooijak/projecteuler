
public class TEN {
    public static void main(String[] aArgs) {
    	long sum = 0;
    	int value = 2000000;
    	
    	for (int i = 0; i < value; i++) {
    		if (isPrime(i)) sum += i;
    	}
    	
    	System.out.println(sum);
    }
    
    static boolean isPrime(int i) {
    	for (int j = 1; j*j < i; j++) {
    		if (i % j == 0) return false;
    	}
    	return true;
    }
}
