using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace LocalNetwork
{
	/// <summary>
	/// Computer comparer.
	/// </summary>
	public class ComputerComparer : IEqualityComparer<Computer>
	{
		public bool Equals(Computer computer1, Computer computer2)
		{
			return computer1.computerID == computer2.computerID;
		}
		public int GetHashCode (Computer computer)
		{
			return computer.computerID;
		}
	}
}

