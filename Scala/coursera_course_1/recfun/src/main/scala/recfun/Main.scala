package recfun

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
    println("Brackets balance")
    println( s"(just an) example --- ${balance( "(just an) example".toList)}")
  }

  /**
   * Exercise 1
   */
    def pascal(c: Int, r: Int): Int = {
      if (c == 0 || c == r)
        1
      else
        pascal(c - 1, r - 1) + pascal(c, r - 1)
    }
  
  /**
   * Exercise 2
   */
    def balance(chars: List[Char]): Boolean = {
      def balanceRec(chars: List[Char], acc: List[Char]): List[Char] = {
        if (chars.isEmpty)
          acc
        else if (chars.head == '(')
          balanceRec(chars.tail, '('::acc)
        else if (chars.head == ')')
          balanceRec(chars.tail, acc.tail)
        else balanceRec(chars.tail, acc)
      }
      balanceRec(chars, List()).isEmpty
    }
  
  /**
   * Exercise 3
   */
    def countChange(money: Int, coins: List[Int]): Int = {
      def recurs(m: Int, cs: List[Int], cnt: Int): Int =
        if (m < 0)
          cnt
        else if (cs.isEmpty) {
          if(m == 0)
            cnt + 1
          else
            cnt
        }
        else
          recurs(m, cs.tail, cnt) + recurs(m - cs.head, cs, cnt)
      recurs(money, coins, 0)
    }
  }
