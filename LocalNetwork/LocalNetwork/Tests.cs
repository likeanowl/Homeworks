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
		public void Contaminate_Computer_test1()
		{
			double chance = 1;
			double pseudorandom = random.Next(101) / 100.0;
			string expected = "True";
			Computer testComp = new Computer(1, "test os", false, chance);
			testComp.Contamination(pseudorandom);
			string actual = testComp.isInfected.ToString();
			Assert.AreEqual(expected, actual);
		}

		[Test]
		public void Contaminate_Computer_test1()
		{
			double chance = 0;
			double pseudorandom = random.Next(101) / 100.0;
			string expected = "False";
			Computer testComp = new Computer(1, "test os", false, chance);
			testComp.Contamination(pseudorandom);
			string actual = testComp.isInfected.ToString();
			Assert.AreEqual(expected, actual);
		}

		/// <summary>
		/// Changeses the after step.
		/// </summary>
		[Test]
		public void Changes_After_Step_test1()
		{
			LocalNetwork testLAN = ParseInputData.ParseData("step_test.txt");
			LocalNetwork exceptedLAN = ParseInputData.ParseData("expected_lan_after_step_test.txt");
			LocalNetwork actual = testLAN.Step();
			for (int i = 0; i < actual.count; i++)
			{
				Assert.AreEqual(actual.keys[i].isInfected.ToString(), 
					exceptedLAN.keys[i].isInfected.ToString());
			}
		}

		[Test]
		public void Changes_After_Step_test2()
		{
			LocalNetwork testLAN = ParseInputData.ParseData("step_test.txt");
			LocalNetwork exceptedLAN = ParseInputData.ParseData("expected_lan_after_step_test.txt");
			LocalNetwork actual = testLAN.Step();
			for (int i = 0; i < actual.count; i++)
			{
				Assert.AreEqual(actual.keys[i].isInfected.ToString(), 
					exceptedLAN.keys[i].isInfected.ToString());
			}
		}

		RandomSingleton random = RandomSingleton.Instance();
	}
}

