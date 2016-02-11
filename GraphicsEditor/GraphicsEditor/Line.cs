using System.Drawing;
using System.Windows.Forms;

namespace GraphicsEditor
{
    /// <summary>
    /// Line descripting class
    /// </summary>
    class Line
    {
        /// <summary>
        /// initalizes new line
        /// </summary>
        /// <param name="startPoint"></param>
        /// <param name="endPoint"></param>
        public Line(Point startPoint, Point endPoint)
        {
            this.startPoint = startPoint;
            this.endPoint = endPoint;
        }

        /// <summary>
        /// initializes new line
        /// </summary>
        /// <param name="line"></param>
        public Line(Line line)
        {
            startPoint = new Point(line.GetXBegin(), line.GetYBegin());
            endPoint = new Point(line.GetXEnd(), line.GetYEnd());
        }

        /// <summary>
        /// changing line ending
        /// </summary>
        /// <param name="endPoint"></param>
        public void ChangeLineEnd(Point endPoint)
        {
            this.endPoint = endPoint;
        }

        /// <summary>
        /// changing line beginning
        /// </summary>
        /// <param name="startPoint"></param>
        public void ChangeLineStart(Point startPoint)
        {
            this.startPoint = startPoint;
        }

        /// <summary>
        /// drawing a line
        /// </summary>
        /// <param name="e"></param>
        public void Draw(PaintEventArgs e)
        {
            e.Graphics.DrawLine(new Pen(Color.Black, 2), startPoint, endPoint);
        }

        /// <summary>
        /// returns X coordinate of line beginning
        /// </summary>
        /// <returns></returns>
        public int GetXBegin()
        {
            return startPoint.X;
        }

        /// <summary>
        /// returns Y coordinate of line beginning
        /// </summary>
        /// <returns></returns>
        public int GetYBegin()
        {
            return startPoint.Y;
        }

        /// <summary>
        /// returns X coordinate of line ending
        /// </summary>
        /// <returns></returns>
        public int GetXEnd()
        {
            return endPoint.X;
        }

        /// <summary>
        /// returns Y coordinate of line ending
        /// </summary>
        /// <returns></returns>
        public int GetYEnd()
        {
            return endPoint.Y;
        }

        private Point startPoint;
        private Point endPoint;
    }
}
