using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;

namespace BinaryTree
{
	/// <summary>
	/// Binary tree.
	/// </summary>
	public class BinaryTree<T> : IEnumerable<T> where T: IComparable
	{
		/// <summary>
		/// Node.
		/// </summary>
		private class Node
		{
			public Node()
			{
				this.lNode = null;
				this.rNode = null;
				this.nodeValue = default(T);
			}

			public Node(T nodeValue)
			{
				this.nodeValue = nodeValue;
			}

			public Node lNode;
			public Node rNode;
			public T nodeValue;
		}

		public BinaryTree()
		{
			root = null;
		}

		private BinaryTree(Node node)
		{
			root = node;
		}

		public BinaryTree(T nodeValue)
		{
			root = new Node(nodeValue);
		}

		/// <summary>
		/// Determines whether this instance is empty.
		/// </summary>
		/// <returns><c>true</c> if this instance is empty; otherwise, <c>false</c>.</returns>
		public bool IsEmpty()
		{
			return root == null;
		}

		/// <summary>
		/// Gets the root value.
		/// </summary>
		/// <returns>The root value.</returns>
		public T GetRootValue()
		{
			T nodeValue = root.nodeValue;
			return nodeValue;
		}

		/// <summary>
		/// Clone this instance.
		/// </summary>
		public BinaryTree<T> Clone()
		{
			BinaryTree<T> newTree = new BinaryTree<T>();
			Clone(newTree);
			return newTree;
		}

		/// <summary>
		/// Clone the Tree.
		/// </summary>
		/// <param name="newTree">New tree.</param>
		private void Clone(BinaryTree<T> newTree)
		{
			newTree.Add(this.GetRootValue());
			if (this.root.rNode != null)
				this.GetRTree().Clone(newTree);
			if (this.root.lNode != null)
				this.GetLTree().Clone(newTree);
		}

		/// <summary>
		/// Add the specified value.
		/// </summary>
		/// <param name="value">value.</param>
		public void Add(T nodeValue)
		{
			Add(ref root, nodeValue);
		}

		private static void Add(ref Node root, T nodeValue)
		{
			if (root == null)
				root = new Node (nodeValue);
			else if (nodeValue.CompareTo(root.nodeValue) < 0)
				Add(ref root.lNode, nodeValue);
			else if (nodeValue.CompareTo(root.nodeValue) > 0)
				Add(ref root.rNode, nodeValue);
		}

		/// <summary>
		/// Gets the left tree.
		/// </summary>
		/// <returns>The L tree.</returns>
		public BinaryTree<T> GetLTree()
		{
			return new BinaryTree<T>(root.lNode);
		}

		/// <summary>
		/// Gets the right tree.
		/// </summary>
		/// <returns>The R tree.</returns>
		public BinaryTree<T> GetRTree()
		{
			return new BinaryTree<T>(root.rNode);
		}

		/// <summary>
		/// Gets the minimum node in right subtree.
		/// </summary>
		/// <returns>The minimum node.</returns>
		private Node GetMinNode()
		{
			return GetMinNode(this.root.rNode);
		}
		private Node GetMinNode(Node node)
		{
			if (node == null)
				return null; 
			if (node.lNode == null) 
				return node; 
			return GetMinNode(node.lNode);
		}
			
		/// <summary>
		/// Delete the specified nodeValue.
		/// </summary>
		/// <param name="nodeValue">nodeValue.</param>
		public void Delete(T nodeValue)
		{
			if (nodeValue.CompareTo(root.nodeValue) > 0)
			{
				BinaryTree<T> rTree = GetRTree();
				rTree.Delete(nodeValue);
				root.rNode = rTree.root;
			}
			else if (nodeValue.CompareTo(root.nodeValue) < 0)
			{
				BinaryTree<T> lTree = GetLTree();
				lTree.Delete(nodeValue);
				root.lNode = lTree.root;
			}
			else
			{
				if (root.lNode != null && root.rNode != null)
				{
					root.nodeValue = GetMinNode().nodeValue;
					BinaryTree<T> rTree = GetRTree();
					rTree.Delete(root.nodeValue);
					root.rNode = rTree.root;
				}
				else if (root.rNode != null)
				{
					root = root.rNode;
				}
				else if (root.lNode != null)
					root = root.lNode;
				else
					root = null;
			}
		}

		/// <summary>
		/// Checking is nodeValue contains in tree
		/// </summary>
		/// <returns><c>true</c> if  this instance is nodeValue in tree the specif ied nodeValue; otherwise, <c>false</c>.</returns>
		/// <param name="nodeValue">nodeValue.</param>
		public bool IsValueInTree(T nodeValue)
		{
			if (root == null)
				return false;
			else 
			{
				if  (nodeValue.CompareTo(root.nodeValue) > 0)
					GetLTree().IsValueInTree(nodeValue);
				else if  (nodeValue.CompareTo(root.nodeValue) < 0)
					GetRTree().IsValueInTree(nodeValue);
				else
					return true;
			}
			return false;
		}

		public string ConvertToString()
		{
			string output = "";
			foreach (T nodeValue in this)
				output += nodeValue + " ";
			return output;
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return (IEnumerator) GetEnumerator();
		}

		public IEnumerator<T> GetEnumerator()
		{
			return new BinaryTreeEnum(this);
		}

		private class BinaryTreeEnum : IEnumerator<T>
		{

			public BinaryTreeEnum(BinaryTree<T> binaryTree)
			{
				treeEnum = new List<T>();
				this.ConvertToArray(binaryTree.root);
			}

			private void ConvertToArray(Node rootNode)
			{
				var queue = new Queue<Node>();
				queue.Enqueue(rootNode); 
				while (queue.Count != 0)
				{    
					if (queue.Peek().lNode != null)
						queue.Enqueue(queue.Peek().lNode);
					if (queue.Peek().rNode != null)
						queue.Enqueue(queue.Peek().rNode);
					treeEnum.Add(queue.Dequeue().nodeValue);
				}
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

			T IEnumerator<T>.Current
			{
				get
				{
					return treeEnum[position];
				}
			}

			public object Current
			{
				get
				{
					return Current;
				}
			}

			public void Dispose()
			{
			}

			private IList<T> treeEnum;
			private int position = -1;
		}

		private Node root;
	}
}

