using System;
using System.IO;
using System.Linq;

namespace BinaryTree
{
	public static class InputParse
	{
		public static BinaryTree<int> ParseFileData (string filename)
		{
			StreamReader file = new StreamReader (filename);
			BinaryTree<int> binTree = new BinaryTree<int> ();
			var numbers = file.ReadLine().Split().Select(Int32.Parse).ToList();
			for (int i = 0; i < numbers.Count; i++)
				binTree.Add (numbers [i]);
			return binTree;
		}
	}
}

