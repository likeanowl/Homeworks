using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace LocalNetwork
{
	/// <summary>
	/// Local network.
	/// </summary>
	public class LocalNetwork 
	{
		RandomSingleton random = RandomSingleton.Instance();

		/// <summary>
		/// Initializes a new instance of the <see cref="LocalNetwork.LocalNetwork"/> class.
		/// </summary>
		public LocalNetwork()
		{
			this.adjacencyList = new Dictionary<Computer, IList<Computer>> (
				new ComputerComparer());
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="LocalNetwork.LocalNetwork"/> class.
		/// </summary>
		/// <param name="adjacencyMatrix">Adjacency matrix.</param>
		/// <param name="pcDescriptions">Pc descriptions.</param>
		public LocalNetwork(Dictionary<int, IList<int>> adjacencyMatrix,
			Dictionary<int,IList<string>> pcDescriptions)
		{
			this.adjacencyList = new Dictionary<Computer, IList<Computer>> (
				adjacencyMatrix.Keys.Count, new ComputerComparer());
			for (int i = 0; i < adjacencyMatrix.Count; i++) 
			{
				bool infected;
				if (pcDescriptions[i][2] == "infected")
					infected = true;
				else
					infected = false;
				Computer currentComp = new Computer(int.Parse(pcDescriptions[i][0]),
					pcDescriptions[i][1],
					infected,
					double.Parse(pcDescriptions[i][3]));
				IList<int> bufferList = adjacencyMatrix[i];
				IList<Computer> compList = new List<Computer>();
				for (int j = 0; j < adjacencyMatrix [i].Count; j++) 
				{
					if (pcDescriptions[bufferList[j]][2] == "infected")
						infected = true;
					else
						infected = false;
					Computer computer = new Computer(int.Parse(pcDescriptions[bufferList[j]][0]),
						pcDescriptions[bufferList[j]][1],
						infected,
						double.Parse(pcDescriptions[bufferList[j]][3]));
					compList.Add(computer);
				}
				this.adjacencyList.Add(currentComp, compList);
			}
		}

		/// <summary>
		/// Makes one step in our system in which each computer
		/// adjacent with infected can be infected with random chance.
		/// </summary>
		public LocalNetwork Step()
		{
			IList<Computer> infectedComputers = new List<Computer>();
			foreach (Computer computer in adjacencyList.Keys) 
			{
				if (computer.isInfected) 
					infectedComputers.Add(computer);
			}
			foreach (Computer computer in infectedComputers) 
			{
					foreach (Computer compInList in adjacencyList[computer]) 
					{
						if (!compInList.isInfected)
							this.adjacencyList.Keys.ToList().Find(((Computer t) => 
								t.computerID == compInList.computerID)).Contamination(
									(double)random.Next (101) / 100.0);
					}
			}
			return this;
		}

		/// <summary>
		/// Gets the information about network state.
		/// </summary>
		/// <param name="stepNumber">Step number.</param>
		public void GetInformation(int stepNumber)
		{
			Console.WriteLine("Network status after step # {0} : ", stepNumber);
			foreach (Computer i in this.adjacencyList.Keys) 
			{
				string infected = "";
				if (i.isInfected)
					infected = "infected";
				else
					infected = "healthy";
				Console.WriteLine("Computer with ID {0} is {1} now", 
					i.computerID, 
					infected);
			}
		}

		/// <summary>
		/// Checking is health computer exist.
		/// </summary>
		/// <returns><c>true</c> if this instance is not infected exist; otherwise, <c>false</c>.</returns>
		public bool IsNotInfectedExist()
		{
			foreach (Computer i in adjacencyList.Keys) 
			{
				if (i.isInfected && adjacencyList[i].Any())
					return true;
			}
			return false;
		}

		public int count { get { return adjacencyList.Keys.Count; } }
		public List<Computer> keys {get { return adjacencyList.Keys.ToList(); } }
		private Dictionary<Computer,IList<Computer>> adjacencyList;
	}
}

