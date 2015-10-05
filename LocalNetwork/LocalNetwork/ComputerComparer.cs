using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace LocalNetwork
{
	public class ComputerComparer : IEqualityComparer<Computer>
	{
		public bool Equals(Computer computer1,Computer computer2)
		{
			return computer1.ComputerId == computer2.ComputerId;
		}
		public int GetHashCode (Computer computer)
		{
			return computer.ComputerId;
		}
	}
}

