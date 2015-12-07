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
			testTree.Add(-1);
			BinaryTree<int> clonedTree = new BinaryTree<int>();
			clonedTree = testTree.Clone();
			string output = "";
			for (int i = 0; i < clonedTree.ConvertToArray().Count; i++)
			{
				output += clonedTree.ConvertToArray()[i].ToString() + " ";
			}
			Console.WriteLine(output);
		}
	}
}
