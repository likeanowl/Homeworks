using System;
using System.Collections;
using System.Linq;
using System.Collections.Generic;

namespace BinaryTree
{
	/// <summary>
	/// Binary tree enum.
	/// </summary>
	public class BinaryTreeEnum<T> : IEnumerator where T : IComparable
	{
		public BinaryTreeEnum(BinaryTree<T> binaryTree)
		{
			treeEnum = new List<T>();
			treeEnum = binaryTree.ConvertToArray();
		}

		public bool MoveNext()
		{
			position++;
			return (position < treeEnum.Count);
		}

		public void Reset()
		{
			position = -1;
		}

		object IEnumerator.Current
		{
			get
			{
				return Current;
			}
		}

		public T Current
		{
			get
			{
				try 
				{
					return treeEnum[position];
				}
				catch (IndexOutOfRangeException)
				{
					throw new InvalidOperationException();
				}
			}
		}

		public IList<T> treeEnum;
		public int position = -1;
	}
}

