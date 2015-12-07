using System;
using NUnit.Framework;

namespace BinaryTree
{
	[TestFixture]
	public class Tests
	{
		/// <summary>
		/// BFS iterator test.
		/// </summary>
		[Test]
		public void ConvertToArray_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int>();
			binTree.Add(3);
			binTree.Add(0);
			binTree.Add(-5);
			binTree.Add(6);
			binTree.Add(-1);
			binTree.Add(-3);
			binTree.Add(11);
			string actual = "";
			for (int i = 0; i < binTree.ConvertToArray().Count; i++)
			{
				actual += binTree.ConvertToArray()[i].ToString() + " ";
			}
			string excepted = "3 0 6 -5 11 -1 -3 ";
			Assert.AreEqual(excepted, actual);
		}

		/// <summary>
		/// Add method test.
		/// </summary>
		[Test]
		public void AddMethod_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int>();
			binTree.Add(3);
			BinaryTree<int> binTree2 = new BinaryTree<int>(3);
			string excepted = "";
			string actual = "";
			for (int i = 0; i < binTree2.ConvertToArray().Count; i++)
			{
				excepted += binTree2.ConvertToArray()[i].ToString() + " ";
			}
			for (int i = 0; i < binTree.ConvertToArray().Count; i++)
			{
				actual += binTree.ConvertToArray()[i].ToString() + " ";
			}
			Assert.AreEqual(excepted, actual);
		}

		/// <summary>
		/// Remove method test.
		/// </summary>
		[Test]
		public void RemoveMethod_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int>();
			binTree.Add(3);
			binTree.Add(0);
			binTree.Add(-5);
			binTree.Add(6);
			binTree.Delete(3);
			string excepted = "6 0 -5 ";
			string actual = "";
			for (int i = 0; i < binTree.ConvertToArray().Count; i++)
			{
				actual += binTree.ConvertToArray()[i].ToString() + " ";
			}
			Assert.AreEqual(excepted, actual);
		}

		[Test]
		public void Iterator_test()
		{
			BinaryTree<int> binTree = new BinaryTree<int>();
			binTree.Add(3);
			binTree.Add(0);
			binTree.Add(-5);
			binTree.Add(6);
			string actual = "";
			string excepted = "3 0 6 -5 ";
			BinaryTreeIterator<int> iterator = new BinaryTreeIterator<int>(binTree);
			foreach (int value in iterator)
			{
				actual += value.ToString() + " ";
			}
			Assert.AreEqual(excepted, actual);
		}
	}
}

