using System;
using System.Collections;

namespace BinaryTree
{
	/// <summary>
	/// Binary tree iterator.
	/// </summary>
	public class BinaryTreeIterator<T> : IEnumerable where T : IComparable
	{
		public BinaryTreeIterator(BinaryTree<T> binaryTree)
		{
			binTree = new BinaryTree<T>();
			binTree = binaryTree.Clone();
		}

		public BinaryTree<T> binTree;
	}
}

