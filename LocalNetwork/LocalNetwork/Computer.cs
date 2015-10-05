using System;

namespace LocalNetwork
{
	public class Computer
	{
		/*implements single computer in LN, like node in graph */
		public Computer()
		{
			this.IsInfected = "healthy";
			this.OsVersion = "";
			this.ChanceToBeInfected = 0.0;
			this.ComputerId = 0;
		}

		public Computer(int computerId, string osVersion, string isInfected, double chanceToBeInfected)
		{
			this.ComputerId = computerId;
			this.IsInfected = isInfected;
			this.OsVersion = osVersion;
			this.ChanceToBeInfected = chanceToBeInfected;
		}

		public void Contamination (double random)
		{
			if (this.ChanceToBeInfected >= random) 
			{
				this.IsInfected = "infected";
			}
		}

		public string IsInfected { get; set; }
		public string OsVersion { get; set; }
		public double ChanceToBeInfected { get; set; }
		public int ComputerId { get; set; }
	}
}

