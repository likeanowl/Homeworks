import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;

public class Main {

    //1
    static double multiplication(double x)
    {
        double sq = x * x;
        return sq * (sq + x) + sq + x + 1;
    }

    //2
    static int div(int a, int b)
    {
        int r = 0;
        int q = 0;
        while (a - b >= r)
        {
            a = a - b;
            q++;
        }
        return q;
    }

    //3
    static int[] reverse(int array[])
    {
        int temp = 0;
        int len = array.length;
        for (int i = 0; i < len / 2; i++)
        {
            temp = array[i];
            array[i] = array[len - i - 1];
            array[len - i - 1] = temp;
        }
        return array;
    }

    //3
    static int[] move(int array[], int shift) {
        int size = array.length;
        int temp = 0;
        array = reverse(array);
        for (int i = 0; i < (size - shift) / 2; i++)
        {
            temp = array[i];
            array[i] = array[size - shift - i - 1];
            array[size - shift - i - 1] = temp;
        }
        for (int i = size - shift; i < size - shift / 2; i++)
        {
            temp = array[i];
            array[i] = array[2 * size - i - shift - 1];
            array[2 * size - i - shift - 1] = temp;
        }
        return array;
    }

    //4
    static long binomial(int n, int k)
    {
        long res = 1;
        for (int i = 0; i < k; i++)
            res = res * (n - i) / (i + 1);
        return res;
    }

    //4
    static int happyTicketsCount()
    {
        int sum = 1;
        for (int i = 3; i < 16; i++)
        {
            if (i >= 12)
            {
                sum += Math.pow(binomial(i, 2) - 3 * binomial(i - 10, 2), 2);
            }
            else
                sum += Math.pow(binomial(i, 2), 2);
        }
        return sum * 2;
    }

    //5
    static boolean bracketSeq(String seq)
    {
        ArrayList<Character> bracketStack = new ArrayList<Character>();
        for (Character ch: seq.toCharArray())
        {
            if (ch.equals('('))
                bracketStack.add(ch);
            else if (ch.equals(')'))
                if (!bracketStack.isEmpty())
                    bracketStack.remove(bracketStack.size() - 1);
                else
                    return false;
        }
        if (!bracketStack.isEmpty())
            return false;
        return true;
    }

    static ArrayList<Integer> prefixFunction(String s)
    {
        ArrayList<Integer> pi = new ArrayList<Integer>(s.length());
        for (int i = 0; i < s.length(); i++)
            pi.add(i, 0);
        for (int i = 1; i < s.length(); i++)
        {
            int j = pi.get(i - 1);
            while (j > 0 && s.charAt(i) != s.charAt(j))
            {
                j = pi.get(j - 1);
            }
            if (s.charAt(i) == s.charAt(j))
                j++;
            pi.set(i, j);
        }
        return pi;
    }

    //6
    static int entersCount(String s1, String s)
    {
        int count = 0;
        ArrayList<Integer> prefFunc = prefixFunction(s1 + "|" + s);
        for (int i: prefFunc)
            if (i == s1.length())
                count++;
        return count;
    }

    static boolean isPrime(int n)
    {
        for (int i = 2; i < (int)Math.sqrt(n) + 1; i++)
            if (n % i == 0)
                return false;
        return true;
    }

    //7
    static void primes(int n)
    {
        for (int i = 2; i < n; i++)
            if (isPrime(i))
                System.out.print(i + " ");
        System.out.println();
    }

    //8
    static BigInteger recFactorial(int n)
    {
        if (n == 0 || n == 1)
            return BigInteger.ONE;
        else
            return BigInteger.valueOf(n).multiply(recFactorial(n - 1));
    }

    //8
    static BigInteger iterFactorial(int n)
    {
        BigInteger res = BigInteger.ONE;
        for (int i = 1; i <= n; i++)
            res = res.multiply(BigInteger.valueOf(i));
        return res;
    }

    //9
    static int fastPow(int a, int n)
    {
        int res = a;
        while (n > 0)
        {
            if (n == 1)
                res *= a;
            a *= a;
            n >>= 1;
        }
        return res;
    }

    //10
    static boolean isPalindrom(String s)
    {
        int halfSize = s.length() / 2;
        ArrayList<Integer> prefFunc = prefixFunction(s);
        return Collections.max(prefFunc) == halfSize;
    }

    //11
    static void qSort(ArrayList<Integer> array, int l, int r)
    {
        int low = l;
        int high = r;
        int midd = array.get(low + (high - low) / 2);
        do {
            while (array.get(low) < midd)
                low++;
            while (array.get(high) > midd)
                high--;
            if (low <= high)
            {
                Collections.swap(array, low, high);
                low++;
                high--;
            }
        } while (low <= high);
        if (l < high)
            qSort(array, l, high);
        if (low < r)
            qSort(array, low, r);
    }

    public static void main(String[] args) {
    }
}
