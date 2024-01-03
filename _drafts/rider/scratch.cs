
using System;
using System.Linq;
using System.Runtime.InteropServices;

class Demo
{
    int[] Reverse()
    {
        var arr = Enumerable.Range(1, 12).ToArray();
        int leftIndex = 3;
        int rightIndex = 7;

        while (leftIndex < rightIndex){
            int tmp = arr[leftIndex];
            arr[leftIndex] = arr[rightIndex];
            arr[rightIndex] = tmp;

            leftIndex++;
            rightIndex--;
        }
        

        return arr;
    }
    
   
}