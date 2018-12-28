package easy

object Solution {
  def twoSum(nums: Array[Int], target: Int): Array[Int] = {
    for (i <- nums.indices) {
      for (j <- i + 1 until nums.length)
        if (nums(i) + nums(j) == target)
          return Array(i, j)
    }
    Array(0, 0)
  }

  def addTwoNumbersRec(first: ListNode, second: ListNode, res: ListNode): Unit = {
    if (first == null && second == null)
      return

    if (first != null)
      res.x += first.x

    if (second != null)
      res.x += second.x

    var over = 0

    if (res.x >= 10) {
      over = 1
      res.x -= 10
    }

    res.next = new ListNode(over)

    addTwoNumbersRec(first.next, second.next, res.next)
  }

  def addTwoNumbers(l1: ListNode, l2: ListNode): ListNode = {
    val list: ListNode = new ListNode()
    addTwoNumbersRec(l1, l2, list)
    list
  }



  class ListNode(var _x: Int = 0) {
    var next: ListNode = _
    var x: Int = _x
  }

}
