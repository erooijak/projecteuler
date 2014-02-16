using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectEuler
{
    /*
     * 
     * The prime factors of 13195 are 5, 7, 13 and 29.
     * What is the largest prime factor of the number 600851475143 ?
     * 
     */

    class Program
    {
        static void Main(string[] args)
        {
            var sw = new Stopwatch();
            sw.Start();

            var number = 600851475143;
            var biggestPrimeFactor = GetFactors(number).Where(factor => IsPrime(factor)).Max();
            
            sw.Stop();
            var elapsed = sw.Elapsed;

            Console.WriteLine("The answer is {0} and it took {1}", biggestPrimeFactor, elapsed);
        }

        static List<long> GetFactors(long number)
        {
            var factors = new List<long>();

            for (long i = 2; i*i < number; i++)
            {
                if (number % i == 0)
                {
                    factors.Add(i);
                }
            }
            return factors;
        }

        static bool IsPrime(long number)
        {
            var isPrime = true;

            for (var i = 2; i*i < number / 2; i++)
            {
                if (number % i == 0)
                {
                    isPrime = false;
                    break;
                }
            }

            return isPrime;
        }
    }
}