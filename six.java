public class six {
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