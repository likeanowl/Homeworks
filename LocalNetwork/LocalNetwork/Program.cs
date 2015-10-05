using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

namespace LocalNetwork
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			/*example for input file in LocalNetwork/bin/Debug*/
			LocalNetwork lan = ParseInputData.ParseData("input.txt");
			lan.GetInformation (0);
			int step = 0;
			while (lan.IsNotInfectedExist()) 
			{
				step++;
				lan.Step ();
				lan.GetInformation (step);
			}
		}
	}
}
