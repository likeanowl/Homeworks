using System;

namespace Robots
{
	/// <summary>
	/// Robot.
	/// </summary>
	public class Robot
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="Robots.Robot"/> class.
		/// </summary>
		public Robot()
		{
			Location = 0;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Robots.Robot"/> class.
		/// </summary>
		/// <param name="location">Location.</param>
		public Robot(int location)
		{
			Location = location;
		}

		/// <summary>
		/// The location of robot.
		/// </summary>
		public int Location;

		/// <summary>
		/// The color. true == white color; false == black
		/// </summary>
		public bool Color;
	}
}

