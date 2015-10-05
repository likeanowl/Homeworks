using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace LocalNetwork
{
	/*implements local network */
	public class LocalNetwork 
	{
		RandomSingleton random = RandomSingleton.Instance();

		public LocalNetwork()
		{
			this._AdjacencyList = new Dictionary<Computer, IList<Computer>> (
				new ComputerComparer());
		}

		public LocalNetwork(Dictionary<int, IList<int>> AdjacencyMatrix,
			Dictionary<int,IList<string>> pcDescriptions)
		{
			this._AdjacencyList = new Dictionary<Computer, IList<Computer>> (
				AdjacencyMatrix.Keys.Count, new ComputerComparer());
			for (int i = 0; i < AdjacencyMatrix.Count; i++) 
			{
				Computer currentComp = new Computer(int.Parse(pcDescriptions [i][0]),
					pcDescriptions [i][1],
					pcDescriptions [i][2],
					double.Parse(pcDescriptions [i][3]));
				IList<int> bufferList = AdjacencyMatrix [i];
				IList<Computer> compList = new List<Computer> ();
				for (int j = 0; j < AdjacencyMatrix [i].Count; j++) 
				{
					Computer computer = new Computer (int.Parse(pcDescriptions [bufferList[j]][0]),
						pcDescriptions [bufferList[j]][1],
						pcDescriptions [bufferList[j]][2],
						double.Parse(pcDescriptions [bufferList[j]][3]));
					compList.Add (computer);
				}
				this._AdjacencyList.Add (currentComp, compList);
			}
		}

		public LocalNetwork Step ()
		{
			/*thought to use bfs at beginning, but finally decided to
			 * use "kostil'" instead*/
			IList<Computer> infectedComputers = new List<Computer> ();
			foreach (Computer computer in _AdjacencyList.Keys) 
			{
				if (computer.IsInfected == "infected") 
					infectedComputers.Add (computer);
			}
			foreach (Computer computer in infectedComputers) 
			{
					foreach (Computer compInList in _AdjacencyList[computer]) 
					{
						if (compInList.IsInfected == "healthy")
							this._AdjacencyList.Keys.ToList ().Find (((Computer t) => 
								t.ComputerId == compInList.ComputerId)).Contamination (
									(double)random.Next (101) / 100.0);
					}
			}
			return this;
		}

		public void GetInformation(int stepNumber)
		{
			Console.WriteLine ("Network status after step # {0} : ", stepNumber);
			foreach (Computer i in this._AdjacencyList.Keys) 
			{
				Console.WriteLine ("Computer with ID {0} is {1} now", 
					i.ComputerId, 
					i.IsInfected);
			}
		}

		public bool IsNotInfectedExist()
		{
			foreach (Computer i in _AdjacencyList.Keys) 
			{
				if (i.IsInfected == "healthy" && _AdjacencyList[i].Any())
					return true;
			}
			return false;
		}

		public int Count { get { return _AdjacencyList.Keys.Count; } }
		public List<Computer> Keys {get { return _AdjacencyList.Keys.ToList(); } }
		private Dictionary<Computer,IList<Computer>> _AdjacencyList;
	}
}

