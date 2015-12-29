using System;
using System.Collections.Generic;
using System.Linq;

namespace Robots
{
	/// <summary>
	/// Robots graph.
	/// This class implements graph oh which we are placing robots.
	/// </summary>
	public class RobotsGraph
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="Robots.RobotsGraph"/> class.
		/// </summary>
		/// <param name="adjList">Adj list.</param>
		/// <param name="robotsList">Robots list.</param>
		public RobotsGraph(Dictionary<int, IList<int>> adjList, IList<Robot> robotsList)
		{
			adjacencyList = adjList;
			this.robotsList = robotsList;
		}

		//another constructor
		/// <summary>
		/// Initializes a new instance of the <see cref="Robots.RobotsGraph"/> class.
		/// </summary>
		/// <param name="adjList">Adj list.</param>
		public RobotsGraph(Dictionary<int, IList<int>> adjList)
		{
			adjacencyList = adjList;
		}

		/// <summary>
		/// Paints the graph.
		/// </summary>
		public void PaintGraph()
		{
			used = new List<bool>();
			color = new List<bool>();
			for (int i = 0; i < adjacencyList.Count; i++)
			{
				used.Add(false);
				color.Add(false);
			}
			color[0] = true;
			PaintGraph(0);
		}
			
		private void PaintGraph(int node)
		{
			used[node] = true;
			for (int i = 0; i < adjacencyList[node].Count; i++)
			{
				int adjacentNode = adjacencyList[node][i];
				if (!used[adjacentNode])
				{
					color[adjacentNode] = !color[node];
					PaintGraph(adjacentNode);
				}
			}
		}
			
		/// <summary>
		/// Checks, is here right any of our conditions 
		///(cycle with not odd lenght of standing on simple colored nodes)
		/// is true
		/// </summary>
		/// <returns><c>true</c> if this instance is sequence exist; otherwise, <c>false</c>.</returns>
		public bool IsSequenceExist()
		{
			int robotsOnWhite = 0;
			int robotsOnBlack = 0;
			this.PaintGraph();
			for (int i = 0; i < robotsList.Count; i++)
			{
				if (color[robotsList[i].Location])
					robotsOnWhite++;
				else
					robotsOnBlack++;
			}
			return (robotsOnBlack != 1 && robotsOnWhite != 1);
		}

		/*this "fields" just used to implement dfs and paint graph methods;
		 * i don't know, where this lists should be, i hope you will 
		 * tell it to me in github comments*/
		private IList<bool> used;
		private IList<bool> color;
		/*rly fields*/
		private IList<Robot> robotsList;
		/*btw i dont actually know where i should place a list, containing all robots
		 * locations. Ive thought that it can be a field of this class;
		 * but if im wrong, pls correct me*/
		public Dictionary <int, IList<int>> adjacencyList;
	}
}

