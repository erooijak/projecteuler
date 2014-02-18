public class six {

	/*
	*
	* The sum of the squares of the first ten natural numbers is,
	* 12 + 22 + ... + 102 = 385
	*
	* The square of the sum of the first ten natural numbers is,
	* (1 + 2 + ... + 10)2 = 552 = 3025
	*
	* Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
	* 
	* Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
	*
	* SOLUTION: BRUTE FORCE
	*
	*/
	public static void main (String[] args) {
		
		int answer = AddAndSquare(100) - SquareAndAdd(100);
		
		System.out.println("The answer is "  + answer);
		
	}
	
	public static int AddAndSquare(int amount) {
		
		int value = 0;	
		
		for (int i = 1; i <= amount; i++) {
			
			value+= i;
		}
		
		return value*value;
	}
	
	public static int SquareAndAdd(int amount) {
		
		int value = 0;	
		int i = 1;
		
		while (i <= amount) {
			value += i*i;
			i++;
					
		}
		
		return value;
	}

}