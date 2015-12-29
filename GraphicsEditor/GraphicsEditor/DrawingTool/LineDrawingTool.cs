using Gtk;
using Cairo;
using System;

namespace GraphicsEditor
{
	class LineDrawingTool
	{
		private Point point1;
		private Point point2;

		public void Init(Point point)
		{
			this.point1 = point;
		}

		public void Move(Point point)
		{
			this.point2 = point;
		}

		public void Draw(PaintEventArgs e)
		{
			e.Graphics.DrawLine(new Pen(Color.Black), this.point1, this.point2);
		}

		public LineDrawingTool GetProduct() => new Line(this.point1, this.point2, this);

	}
}

