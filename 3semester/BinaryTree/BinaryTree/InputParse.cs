using System;
using System.IO;
using System.Linq;

namespace BinaryTree
{
	/// <summary>
	/// Input parse.
	/// </summary>
	public static class InputParse
	{
		/// <summary>
		/// Parses the file data.
		/// </summary>
		/// <returns>The file data.</returns>
		/// <param name="filename">Filename.</param>
		public static BinaryTree<int> ParseFileData(string filename)
		{
			StreamReader file = new StreamReader(filename);
			BinaryTree<int> binTree = new BinaryTree<int>();
			var numbers = file.ReadLine().Split().Select(Int32.Parse).ToList();
			for (int i = 0; i < numbers.Count; i++)
				binTree.Add (numbers[i]);
			return binTree;
		}
	}
}

