using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Windows.Forms;

namespace GraphicsEditor
{
    class Line
    {
        public Line(Point startPoint, Point endPoint)
        {
            this.startPoint = startPoint;
            this.endPoint = endPoint;
        }

        public Line(Line line)
        {
            startPoint = new Point(line.GetXBegin(), line.GetYBegin());
            endPoint = new Point(line.GetXEnd(), line.GetYEnd());
        }

        public void ChangeLineEnd(Point endPoint)
        {
            this.endPoint = endPoint;
        }

        public void ChangeLineStart(Point startPoint)
        {
            this.startPoint = startPoint;
        }

        public void Draw(PaintEventArgs e)
        {
            e.Graphics.DrawLine(new Pen(Color.Black, 2), startPoint, endPoint);
        }

        public int GetXBegin()
        {
            return startPoint.X;
        }

        public int GetYBegin()
        {
            return startPoint.Y;
        }

        public int GetXEnd()
        {
            return endPoint.X;
        }

        public int GetYEnd()
        {
            return endPoint.Y;
        }
        private Point startPoint;
        private Point endPoint;
    }
}
