using System;

namespace LocalNetwork
{
	public class RandomSingleton : Random
	{
		/// <summary>
		///singleton pattern for Random
		/// </summary>
		static RandomSingleton instance;

		public static RandomSingleton Instance()
		{ 
			if (instance == null)	
				instance = new RandomSingleton();
			return instance;
		}

		private RandomSingleton() {} 
	}
}

