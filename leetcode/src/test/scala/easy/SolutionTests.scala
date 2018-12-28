package easy

import easy.Solution.ListNode
import org.scalatest.FunSuite

class SolutionTests extends FunSuite {
  test("twoSumTest") {
    assert(Solution.twoSum(Array(2, 7, 11, 15), 9) === Array(0, 1))
  }

  test("addTwoNumbersTest") {
    val l1: ListNode = new ListNode(2)
    l1.next = new ListNode(4)
    l1.next.next = new ListNode(3)

    val l2: ListNode = new ListNode(5)
    l2.next = new ListNode(6)
    l2.next.next = new ListNode(4)

    val res = Solution.addTwoNumbers(l1, l2)
    assert(res.x === 7)
    assert(res.next.x === 0)
    assert(res.next.next.x === 8)
  }
}
