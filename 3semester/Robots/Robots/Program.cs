using System;

namespace Robots
{
	class MainClass
	{
		/// <summary>
		/// The entry point of the program, where the program control starts and ends.
		/// </summary>
		/// <param name="args">The command-line arguments.</param>
		public static void Main(string[] args)
		{
			RobotsGraph graph = InputParse.CreateObjectFromFile("input.txt", 
				"inputlocation.txt");
			Console.WriteLine(graph.IsSequenceExist());
		}
	}
}
