using System;
using NUnit.Framework;

namespace BinaryTree
{
	[TestFixture]
	public class Tests
	{
		[Test]
		public void BFSIterator_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int> ();
			binTree.Add (3);
			binTree.Add (0);
			binTree.Add (-5);
			binTree.Add (6);
			binTree.Add (-1);
			binTree.Add (-3);
			binTree.Add (11);
			string actual = binTree.BFSIterator ();
			string excepted = "3 0 6 -5 11 -1 -3";
			Assert.AreEqual (excepted, actual);
		}

		[Test]
		public void Add_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int> ();
			binTree.Add (3);
			Node<int> testnode = new Node<int> (3);
			BinaryTree<int> binTree2 = new BinaryTree<int> (testnode);
			string excepted = binTree2.BFSIterator ();
			string actual = binTree.BFSIterator ();
			Assert.AreEqual (excepted, actual);
		}

		[Test]
		public void Remove_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int> ();
			binTree.Add (3);
			binTree.Add (0);
			binTree.Add (-5);
			binTree.Add (6);
			binTree.Delete (3);
			string excepted = "6 0 -5";
			string actual = binTree.BFSIterator ();
			Assert.AreEqual (excepted, actual);
		}
	}
}

