using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _5
{
    /*
     * 
     * 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
     * 
     * What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
     * 
     */

    class Program
    {
        static void Main(string[] args)
        {

            var sw = new Stopwatch();
            sw.Start();

            var answer = GetAnswer();

            sw.Stop();
            var elapsed = sw.Elapsed;
            Console.WriteLine("The answer is {0} and it took {1}", answer, elapsed);

        }

        static long GetAnswer()
        {
            var found = false;
            long value = 0;
            var numbers1till20 = new List<int>();

            for (var i = 1; i <= 20; i++)
            {
                numbers1till20.Add(i);
            }

            while (!found)
            {
                value++;
                if (numbers1till20.All(v => value % v == 0)) found = true;         
            }

            return value;
        }
    }
}
