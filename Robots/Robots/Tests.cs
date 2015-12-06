using System;
using NUnit.Framework;
using System.IO;

namespace Robots
{
	[TestFixture]
	public class Tests
	{
		/// <summary>
		/// Paints the graph test.
		/// </summary>
		[Test]
		public void PaintGraph_test()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData (
				                        "FindCompTestFile.txt"));
			testGraph.PaintGraph();
			string actual = "";
			for (int i = 0; i < testGraph.color.Count; i++)
			{
				if (i != testGraph.color.Count - 1)
					actual += testGraph.color[i].ToString() + " ";
				else
					actual += testGraph.color[i].ToString();
			}
			string excepted = "True False True False True False";
			Assert.AreEqual(excepted, actual);
		}
		/// <summary>
		/// Finds the odd cycle test.
		/// </summary>
		[Test]
		public void FindOddCycle_test()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData (
				                        "FindCompTestFile.txt"));
			string actual = testGraph.FindOddCycle().ToString();
			string excepted = "True";
			Assert.AreEqual(excepted, actual);
		}
	}
}

