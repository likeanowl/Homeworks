using System;
using System.Collections.Generic;
using System.Linq;

namespace BinaryTree
{
	public class BinaryTree<T> where T: IComparable
	{
		public BinaryTree ()
		{
			Root = null;
		}

		public BinaryTree (Node<T> node)
		{
			Root = node;
		}

		public bool IsEmpty()
		{
			return Root == null;
		}

		public void Add(T value)
		{
			Add (ref Root, value);
		}

		private static void Add(ref Node<T> Root, T value)
		{
			if (Root == null)
				Root = new Node<T> (value);
			else if (value.CompareTo(Root.Value) < 0)
				Add (ref Root.LNode, value);
			else if (value.CompareTo(Root.Value) > 0)
				Add (ref Root.RNode, value);
		}

		public BinaryTree<T> GetLTree ()
		{
			return new BinaryTree<T> (Root.LNode);
		}

		public BinaryTree<T> GetRTree ()
		{
			return new BinaryTree<T> (Root.RNode);
		}

		public Node<T> GetMinNode()
		{
			return GetMinNode (this.Root.RNode);
		}
		private Node<T> GetMinNode(Node<T> node)
		{
			if (node == null)
				return null; 
			if (node.LNode == null) 
				return node; 
			return GetMinNode(node.LNode);
		}
			
		public void Delete(T value)
		{
			if (value.CompareTo (Root.Value) > 0)
			{
				BinaryTree<T> rTree = GetRTree ();
				rTree.Delete (value);
				Root.RNode = rTree.Root;
			}
			else if (value.CompareTo (Root.Value) < 0)
			{
				BinaryTree<T> lTree = GetLTree ();
				lTree.Delete (value);
				Root.LNode = lTree.Root;
			}
			else
			{
				if (Root.LNode != null && Root.RNode != null)
				{
					Root.Value = GetMinNode ().Value;
					BinaryTree<T> rTree = GetRTree ();
					rTree.Delete (Root.Value);
					Root.RNode = rTree.Root;
				}
				else if (Root.RNode != null)
				{
					Root = Root.RNode;
				}
				else if (Root.LNode != null)
					Root = Root.LNode;
				else
					Root = null;
			}
		}

		public string BFSIterator()
		{
			string outputString = "";
			var queue = new Queue<Node<T>>();
			queue.Enqueue(Root); 
			while (queue.Count!=0)
			{    
				if (queue.Peek().LNode != null)
					queue.Enqueue(queue.Peek().LNode);
				if (queue.Peek().RNode != null)
					queue.Enqueue(queue.Peek().RNode);
				if (queue.Count > 1)
					outputString += queue.Dequeue ().Value.ToString () + " ";
				else
					outputString += queue.Dequeue ().Value.ToString ();
			}
			return outputString;
		} 

		public bool IsExist(T value)
		{
			if (Root == null)
				return false;
			else 
			{
				if (value.CompareTo (Root.Value) > 0)
					GetLTree ().IsExist (value);
				else if (value.CompareTo (Root.Value) < 0)
					GetRTree ().IsExist (value);
				else
					return true;
			}
			return false;
		}

		public Node<T> Root;
	}
}

