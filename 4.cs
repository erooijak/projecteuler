using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;

namespace _4
{
    /*
     * 
     * A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
     * 
     * Find the largest palindrome made from the product of two 3-digit numbers.
     * 
     */

    class Program
    {
        static void Main(string[] args)
        {
            var sw = new Stopwatch();
            sw.Start();

            var largestProduct = 999;
            var palindromes = GetPalindromes(largestProduct);

            sw.Stop();
            var elapsed = sw.Elapsed;

            Console.WriteLine(palindromes + "\n Time elapsed: {0}", elapsed);    
        }

        static string GetPalindromes(int largestProduct)
        {
            var palindromes = "";
            var highestValueSoFar = 0;
            for (int i = 1; i < largestProduct; i++)
            {
                for (int j = 1; j < largestProduct; j++)
                {
                   
                    var value = i * j;
                    if (value > highestValueSoFar && IsPalindrome(value)) 
                    {

                        palindromes = String.Format("The largest palindrome made from the product of two 3-digit numbers is {0} and " +
                        "is the product of {1} and {2}", i*j, i, j);

                         highestValueSoFar = value;
                    }
             
                }
            }
            return palindromes;
        }


        static bool IsPalindrome(int number)
        {
            var isPalindrome = false;
            var characters = number.ToString().ToCharArray();
            var length = characters.Length;

            if (length == 2 || length == 3)
            {
                if (characters.First() == characters.Last()) isPalindrome = true;
            }

            if (length == 4) 
            {
                if (characters.First() == characters.Last() && characters.ElementAt(1) == characters.ElementAt(2)) isPalindrome = true;
            }

            if (length == 5) 
            {
                if (characters.First() == characters.Last() && characters.ElementAt(1) == characters.ElementAt(3)) isPalindrome = true;
            }
            if (length == 6)
            {
                if (characters.First() == characters.Last() && characters.ElementAt(1) == characters.ElementAt(4)
                     && characters.ElementAt(2) == characters.ElementAt(3)) isPalindrome = true;
            }

            return isPalindrome;

        }
    }
}
