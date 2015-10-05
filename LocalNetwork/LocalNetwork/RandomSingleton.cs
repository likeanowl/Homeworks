using System;

namespace LocalNetwork
{
	public class RandomSingleton : Random
	{
		/*singleton pattern for Random */
		static RandomSingleton _Instance;

		public static RandomSingleton Instance()
		{ 
			if (_Instance == null)	_Instance = new RandomSingleton();
			return _Instance;
		}
		private RandomSingleton() {} 
	}
}

