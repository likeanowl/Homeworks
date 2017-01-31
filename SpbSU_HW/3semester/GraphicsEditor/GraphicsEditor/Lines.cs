using System.Collections.Generic;
using System.Windows.Forms;

namespace GraphicsEditor
{
    /// <summary>
    /// Describes lines class with some logic
    /// </summary>
    class Lines
    {
        /// <summary>
        /// initializing a new empty lines list
        /// </summary>
        public Lines()
        {
            lines = new List<Line>();
        }

        /// <summary>
        /// adds a line to an existing list
        /// </summary>
        /// <param name="line"></param>
        public void AddLine(Line line)
        {
            lines.Add(line);
        }

        /// <summary>
        /// indexator
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public Line this[int index]
        {
            get { return lines[index]; }
            set { lines[index] = value; }
        }

        /// <summary>
        /// gets the current state of lines list
        /// </summary>
        /// <returns></returns>
        public List<Line> GetState()
        {
            List<Line> newList = new List<Line>();
            foreach (Line line in lines)
            {
                newList.Add(new Line(line));
            }
            return newList;
        }

        /// <summary>
        /// setting new state to lines list
        /// </summary>
        /// <param name="newList"></param>
        public void SetState(List<Line> newList)
        {
            lines = newList;
        }

        /// <summary>
        /// drawing each line from list
        /// </summary>
        /// <param name="e"></param>
        public void Draw(PaintEventArgs e)
        {
            foreach (Line line in lines)
            {
                line.Draw(e);
            }
        }

        /// <summary>
        /// finds nearest line to selected point
        /// </summary>
        /// <param name="point"></param>
        /// <returns></returns>
        public Line FindNearestLine(System.Drawing.Point point)
        {
            foreach (Line line in lines)
            {
                if (LogicHelper.IntervalBetweenPointAndLine(line, point) <= 7)
                    return line;
            }
            return null;
        }

        /// <summary>
        /// deleting line
        /// </summary>
        /// <param name="line"></param>
        public void DeleteLine(Line line)
        {
            lines.RemoveAt(lines.IndexOf(line));
        }

        private IList<Line> lines;
        public int Count { get { return lines.Count; } }
    }
}
