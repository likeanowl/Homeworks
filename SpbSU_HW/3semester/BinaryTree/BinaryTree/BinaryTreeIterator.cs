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

		IEnumerator IEnumerable.GetEnumerator()
		{
			return (IEnumerator) GetEnumerator();
		}

		public BinaryTreeEnum<T> GetEnumerator()
		{
			return new BinaryTreeEnum<T>(binTree);
		}

		public BinaryTree<T> binTree;
	}
}

