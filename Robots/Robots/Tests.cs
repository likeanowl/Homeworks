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
		public void PaintGraph_test1()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData(
				"FindCompTestFile1.txt"));
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

		[Test]
		public void PaintGraph_test2()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData(
				"FindCompTestFile2.txt"));
			testGraph.PaintGraph();
			string actual = "";
			for (int i = 0; i < testGraph.color.Count; i++)
			{
				if (i != testGraph.color.Count - 1)
					actual += testGraph.color[i].ToString() + " ";
				else
					actual += testGraph.color[i].ToString();
			}
			string excepted = "True False True False";
			Assert.AreEqual(excepted, actual);
		}

		[Test]
		public void PaintGraph_test3()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData(
				"FindCompTestFile3.txt"));
			testGraph.PaintGraph();
			string actual = "";
			for (int i = 0; i < testGraph.color.Count; i++)
			{
				if (i != testGraph.color.Count - 1)
					actual += testGraph.color[i].ToString() + " ";
				else
					actual += testGraph.color[i].ToString();
			}
			string excepted = "True False True False";
			Assert.AreEqual(excepted, actual);
		}

		[Test]
		public void IsSequenceExist_test1()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData(
				                        "SequenceTest1.txt"));
			string actual = testGraph.IsSequenceExist().ToString();
			string expected = "True";
			Assert.AreEqual(expected, actual);
		}

		[Test]
		public void IsSequenceExist_test2()
		{
			RobotsGraph testGraph = new RobotsGraph(InputParse.ParseGraphData(
				"SequenceTest2.txt"));
			string actual = testGraph.IsSequenceExist().ToString();
			string expected = "False";
			Assert.AreEqual(expected, actual);
		}
	}
}

