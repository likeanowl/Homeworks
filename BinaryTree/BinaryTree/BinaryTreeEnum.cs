using System;
using System.Collections;

namespace BinaryTree
{
	/// <summary>
	/// Binary tree enum.
	/// </summary>
	public class BinaryTreeEnum<T> : IEnumerator where T : IComparable
	{
		public BinaryTreeEnum(BinaryTree<T> binaryTree)
		{
			binTree = new BinaryTree<T>();
			binTree = binaryTree.Clone();
		}

		public BinaryTree<T> binTree;
		public int position = -1;
	}
}

