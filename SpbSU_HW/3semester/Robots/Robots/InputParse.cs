using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace Robots
{
	public static class InputParse
	{
		/*first file contains count of nodes and adjacency list for our graph;
		 * second file contains robots count and their locations on our graph*/
		/// <summary>
		/// Reads files and parses it into data we need
		/// </summary>
		/// <returns>The graph data.</returns>
		/// <param name="graphFilename">Graph filename.</param>
		public static Dictionary<int, IList<int>> ParseGraphData(string graphFilename)
		{
			StreamReader graphFile = new StreamReader(graphFilename);
			int count = int.Parse (graphFile.ReadLine());
			Dictionary<int, IList<int>> adjacencyList = new Dictionary<int, IList<int>>(count);
			for (int i = 0; i < count; i++) 
			{
				string[] bufferArray = graphFile.ReadLine().Split(' ');
				IList<int> bufferList = new List<int>();
				for (int j = 1; j < bufferArray.Length; j++)
					bufferList.Add(int.Parse (bufferArray [j]));
				adjacencyList.Add(i, bufferList);
			}
			graphFile.Close();
			return adjacencyList;
		}

		/// <summary>
		/// Parses the robot locations data.
		/// </summary>
		/// <returns>The robot locations data.</returns>
		/// <param name="locationsFilename">Locations filename.</param>
		public static IList<Robot> ParseRobotLocationsData(string locationsFilename)
		{
			StreamReader locationsFile = new StreamReader(locationsFilename); 
			int count = int.Parse(locationsFile.ReadLine());
			IList<Robot> robotsList = new List<Robot>();
			for (int i = 0; i < count; i++)
			{
				robotsList.Add(new Robot(int.Parse (locationsFile.ReadLine ())));
			}
			locationsFile.Close();
			return robotsList;
		}

		/// <summary>
		/// Creates the object from file.
		/// </summary>
		/// <returns>The object from file.</returns>
		/// <param name="graphFilename">Graph filename.</param>
		/// <param name="locationsFilename">Locations filename.</param>
		public static RobotsGraph CreateObjectFromFile(string graphFilename, string locationsFilename)
		{
			return new RobotsGraph(ParseGraphData(graphFilename),
				ParseRobotLocationsData(locationsFilename));
		}
	}
}

