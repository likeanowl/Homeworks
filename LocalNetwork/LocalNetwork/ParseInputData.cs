using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

namespace LocalNetwork
{
	public static class ParseInputData
	{
		/// <summary>
		/// Reads file and parses it into data we need to create local network
		/// </summary>
		/// <returns>The data.</returns>
		/// <param name="filename">Filename.</param>
		public static LocalNetwork ParseData(string filename)
		{
			StreamReader file = new StreamReader (filename);
			int count = int.Parse (file.ReadLine ());
			Dictionary<int, IList<int>> adjacencyList = new Dictionary<int, IList<int>> (count);
			//this dictionary should contain a number of pc as key and list of pc ID's 
			for (int i = 0; i < count; i++) {
				string[] bufferArray = file.ReadLine ().Split (' ');
				IList<int> bufferList = new List<int> ();
				for (int j = 1; j < bufferArray.Length; j++)
					bufferList.Add (int.Parse (bufferArray [j]));
				adjacencyList.Add (i, bufferList);
			}
			/*string descripting a computer which is incident to computer with id = key  
			* each string contains : computer id, computer os, is computer infected, computer chance to become infected
			* splitted by spaces*/
			Dictionary<int, IList<string>> pcDescriptions = new Dictionary<int, IList<string>> (count);
			for (int i = 0; i < count; i++) {
				string[] bufferArray = file.ReadLine ().Split ();
				IList<string> bufferList = new List<string> ();
				for (int j = 0; j < bufferArray.Length; j++)
					bufferList.Add (bufferArray [j]);
				pcDescriptions.Add (int.Parse (bufferArray [0]), bufferList);
			}
			file.Close ();
			return new LocalNetwork (adjacencyList, pcDescriptions);
		}
	}
}

