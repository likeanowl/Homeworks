using System;

namespace LocalNetwork
{
	/// <summary>
	/// Computer.
	/// </summary>
	public class Computer
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="LocalNetwork.Computer"/> class.
		/// </summary>
		/*implements single computer in LN, like node in graph */
		public Computer()
		{
			this.isInfected = false;
			this.osVersion = "";
			this.chanceToBeInfected = 0.0;
			this.computerID = 0;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="LocalNetwork.Computer"/> class.
		/// </summary>
		/// <param name="computerId">Computer identifier.</param>
		/// <param name="osVersion">Os version.</param>
		/// <param name="isInfected">Is infected.</param>
		/// <param name="chanceToBeInfected">Chance to be infected.</param>
		public Computer(int computerId, string osVersion, string isInfected, double chanceToBeInfected)
		{
			this.computerID = computerID;
			this.isInfected = isInfected;
			this.osVersion = osVersion;
			this.chanceToBeInfected = chanceToBeInfected;
		}

		/// <summary>
		/// Contaminate computer with random chance.
		/// </summary>
		/// <param name="random">Random.</param>
		public void Contamination(double random)
		{
			if (this.chanceToBeInfected >= random) 
			{
				this.isInfected = true;
			}
		}

		public bool isInfected { get; set; }
		public string osVersion { get; set; }
		public double chanceToBeInfected { get; set; }
		public int computerID { get; set; }
	}
}

