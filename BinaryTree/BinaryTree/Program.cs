using System;

namespace BinaryTree
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			BinaryTree<int> binTree = InputParse.ParseFileData ("input.txt");
			Console.WriteLine (binTree.BFSIterator ());
		}
	}
}
