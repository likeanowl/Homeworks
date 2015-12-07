using System;
using NUnit.Framework;
using System.Linq;
using System.Collections.Generic;

namespace LocalNetwork
{
	[TestFixture]
	public class Tests
	{

		/// <summary>
		/// Contaminates the computer.
		/// </summary>
		[Test]
		public void Contaminate_Computer_test()
		{
			double chance = 0.5;
			double pseudorandom = random.Next(101)/100.0;
			if (pseudorandom >= 0.5) {
				string expected = "False";
				Computer testComp = new Computer(1, "test os", "healthy", chance);
				testComp.Contamination(pseudorandom);
				string actual = testComp.isInfected;
				Assert.AreEqual(expected, actual, "Contamination is not correct");
			} 
			else 
			{
				string expected = "True";
				Computer testComp = new Computer(1, "test os", "healthy", chance);
				testComp.Contamination(pseudorandom);
				string actual = testComp.isInfected;
				Assert.AreEqual(expected, actual, "Contamination is not working correct");
			}

		}

		/// <summary>
		/// Changeses the after step.
		/// </summary>
		[Test]
		public void Changes_After_Step_test()
		{
			LocalNetwork testLAN = ParseInputData.ParseData("step_test.txt");
			LocalNetwork exceptedLAN = ParseInputData.ParseData("expected_lan_after_step_test.txt");
			LocalNetwork actual = testLAN.Step();
			for (int i = 0; i<actual.Count; i++)
			{
				Assert.AreEqual(actual.keys[i].isInfected.ToString(), 
					exceptedLAN.keys[i].isInfected.ToString());
			}
		}

		RandomSingleton random = RandomSingleton.Instance();
	}
}

