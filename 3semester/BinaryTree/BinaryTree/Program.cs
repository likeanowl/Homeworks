using System;

namespace BinaryTree
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			BinaryTree<int> testTree = new BinaryTree<int>();
			testTree.Add(1);
			testTree.Add(2);
			testTree.Add(0);
			testTree.Add(4);
			BinaryTree<int> clonedTree = new BinaryTree<int>();
			clonedTree = testTree.Clone();
			Console.WriteLine(clonedTree.ConvertToString());
			Console.WriteLine(testTree.ConvertToString());
		}
	}
}
