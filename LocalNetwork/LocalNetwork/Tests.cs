using System;
using NUnit.Framework;
using System.Linq;
using System.Collections.Generic;

namespace LocalNetwork
{
	[TestFixture]
	public class Tests
	{

		[Test]
		public void Contaminate_Computer()
		{
			double chance = 0.5;
			double pseudorandom = random.Next(101)/100.0;
			if (pseudorandom >= 0.5) {
				string expected = "healthy";
				Computer testComp = new Computer (1, "test os", "healthy", chance);
				testComp.Contamination (pseudorandom);
				string actual = testComp.IsInfected;
				Assert.AreEqual (expected, actual, "Contamination is not correct");
			} else {
				string expected = "infected";
				Computer testComp = new Computer (1, "test os", "healthy", chance);
				testComp.Contamination (pseudorandom);
				string actual = testComp.IsInfected;
				Assert.AreEqual (expected, actual, "Contamination is not working correct");
			}

		}

		[Test]
		public void Changes_After_Step()
		{
			LocalNetwork testLAN = ParseInputData.ParseData ("step_test.txt");
			LocalNetwork exceptedLAN = ParseInputData.ParseData ("expected_lan_after_step_test.txt");
			LocalNetwork actual = testLAN.Step ();
			for (int i = 0; i<actual.Count; i++)
			{
				Assert.AreEqual (actual.Keys[i].IsInfected, exceptedLAN.Keys[i].IsInfected);
			}
		}

		RandomSingleton random = RandomSingleton.Instance();
	}
}

