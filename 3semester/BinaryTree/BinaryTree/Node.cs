using System;

namespace BinaryTree
{
	/// <summary>
	/// Node.
	/// </summary>
	public class Node<T> where T:IComparable
	{
		public Node()
		{
			this.LNode = null;
			this.RNode = null;
			this.Value = default(T);
		}

		public Node(T value)
		{
			this.Value = value;
		}
		public Node<T> LNode;
		public Node<T> RNode;
		public T Value;
	}
}

