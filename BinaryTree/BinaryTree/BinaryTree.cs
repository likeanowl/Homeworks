using System;
using System.Collections.Generic;
using System.Linq;

namespace BinaryTree
{
	/// <summary>
	/// Binary tree.
	/// </summary>
	public class BinaryTree<T> where T: IComparable
	{
		/// <summary>
		/// Node.
		/// </summary>
		private class Node<T>
		{
			public Node()
			{
				this.lNode = null;
				this.rNode = null;
				this.value = default(T);
			}

			public Node(T value)
			{
				this.value = value;
			}
			public Node<T> lNode;
			public Node<T> rNode;
			public T value;
		}

		public BinaryTree ()
		{
			root = null;
		}

		private BinaryTree (Node<T> node)
		{
			root = node;
		}

		public BinaryTree (T value)
		{
			root = new Node<T>(value);
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
			T value = root.value;
			return value;
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
		public void Add(T value)
		{
			Add(ref root, value);
		}

		private static void Add(ref Node<T> root, T value)
		{
			if (root == null)
				root = new Node<T> (value);
			else if (value.CompareTo(root.value) < 0)
				Add(ref root.lNode, value);
			else if (value.CompareTo(root.value) > 0)
				Add(ref root.rNode, value);
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
		private Node<T> GetMinNode()
		{
			return GetMinNode(this.root.rNode);
		}
		private Node<T> GetMinNode(Node<T> node)
		{
			if (node == null)
				return null; 
			if (node.lNode == null) 
				return node; 
			return GetMinNode(node.lNode);
		}
			
		/// <summary>
		/// Delete the specified value.
		/// </summary>
		/// <param name="value">value.</param>
		public void Delete(T value)
		{
			if (value.CompareTo(root.value) > 0)
			{
				BinaryTree<T> rTree = GetRTree();
				rTree.Delete(value);
				root.rNode = rTree.root;
			}
			else if (value.CompareTo(root.value) < 0)
			{
				BinaryTree<T> lTree = GetLTree();
				lTree.Delete(value);
				root.lNode = lTree.root;
			}
			else
			{
				if (root.lNode != null && root.rNode != null)
				{
					root.value = GetMinNode().value;
					BinaryTree<T> rTree = GetRTree();
					rTree.Delete(root.value);
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
			
		public List<T> ConvertToArray()
		{
			List<T> outputList = new List<T>();
			var queue = new Queue<Node<T>>();
			queue.Enqueue(root); 
			while(queue.Count!=0)
			{    
				if (queue.Peek().lNode != null)
					queue.Enqueue(queue.Peek().lNode);
				if (queue.Peek().rNode != null)
					queue.Enqueue(queue.Peek().rNode);
				outputList.Add(queue.Dequeue().value);
			}
			return outputList;
		} 

		/// <summary>
		/// Checking is value contains in tree
		/// </summary>
		/// <returns><c>true</c> if  this instance is value in tree the specif ied value; otherwise, <c>false</c>.</returns>
		/// <param name="value">value.</param>
		public bool IsValueInTree(T value)
		{
			if (root == null)
				return false;
			else 
			{
				if  (value.CompareTo(root.value) > 0)
					GetLTree().IsValueInTree(value);
				else if  (value.CompareTo(root.value) < 0)
					GetRTree().IsValueInTree(value);
				else
					return true;
			}
			return false;
		}

		private Node<T> root;
	}
}

