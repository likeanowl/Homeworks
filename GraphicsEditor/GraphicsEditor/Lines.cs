using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GraphicsEditor
{
    class Lines
    {
        public Lines()
        {
            lines = new List<Line>();
        }

        public void AddLine(Line line)
        {
            lines.Add(line);
        }

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

        public void SetState(List<Line> newList)
        {
            lines = newList;
        }

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

        public void DeleteLine(Line line)
        {
            lines.RemoveAt(lines.IndexOf(line));
        }

        private IList<Line> lines;
        public int Count { get { return lines.Count; } }
    }
}
