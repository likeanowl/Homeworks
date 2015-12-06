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
			AdjacencyList = adjList;
			RobotsList = robotsList;
		}

		//another constructor
		/// <summary>
		/// Initializes a new instance of the <see cref="Robots.RobotsGraph"/> class.
		/// </summary>
		/// <param name="adjList">Adj list.</param>
		public RobotsGraph(Dictionary<int, IList<int>> adjList)
		{
			AdjacencyList = adjList;
		}

		/// <summary>
		/// Finds the cycle with odd length.
		/// </summary>
		/// <returns><c>true</c>, if odd cycle was found, <c>false</c> otherwise.</returns>
		public bool FindOddCycle()
		{
			used = new List<bool>();
			cyclesList = new List<Queue<int>>();
			for (int i = 0; i < AdjacencyList.Count; i++)
			{
				cyclesList.Add(new Queue<int>());
				used.Add(false);
			}
			return FindOddCycle(0);
		}

		/*Alghoritm in general words :
		 * modified dfs, checking if we were in this node or no:
		 * we weren't : adds this node to queue in list of queues, where
		 * each queue is a sequence of nodes starting from node with 
		 * index-of-queue-in-list number.
		 * we were : then sequence of nodes is cycle and if it has
		 * odd length then we done, else - just continue searching*/

		private bool FindOddCycle(int node)
		{
			used[node] = true;
			for (int i = 0; i < AdjacencyList[node].Count; i++)
			{
				int adjacentNode = AdjacencyList[node][i];
				if (!used[adjacentNode])
				{
					cyclesList[i].Enqueue(adjacentNode);
					FindOddCycle(adjacentNode);
				}
				else
				{
					if (cyclesList[adjacentNode].Count % 2 == 0 && cyclesList[adjacentNode].Count > 1)
					{
						result = true;
						return result;
					}
				}
			}
			return result;
		}

		/// <summary>
		/// Paints the graph.
		/// </summary>
		public void PaintGraph()
		{
			used = new List<bool>();
			color = new List<bool>();
			for (int i = 0; i < AdjacencyList.Count; i++)
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
			for (int i = 0; i < AdjacencyList[node].Count; i++)
			{
				int adjacentNode = AdjacencyList[node][i];
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
			if (this.FindOddCycle(0))
				return true;
			else
			{
				this.PaintGraph();
				for (int i = 1; i<RobotsList.Count; i++)
				{
					if (color [RobotsList[i].Location] != color[RobotsList[0].Location])
						return false;
				}
			}
			return true;
		}

		/*this "fields" just used to implement dfs and paint graph methods;
		 * i don't know, where this lists should be, i hope you will 
		 * tell it to me in github comments*/
		public IList<bool> used;
		public IList<int> adjacencyComponent;
		public IList<bool> color;
		public IList<Queue<int>> cyclesList;
		/*rly fields*/
		private IList<Robot> RobotsList;
		/*btw i dont actually know where i should place a list, containing all robots
		 * locations. Ive thought that it can be a field of this class;
		 * but if im wrong, pls correct me*/
		public Dictionary <int, IList<int>> AdjacencyList;
		/*using this "kostil'" for returning from multiply recursion in DFS method*/
		private bool result = false;
	}
}

