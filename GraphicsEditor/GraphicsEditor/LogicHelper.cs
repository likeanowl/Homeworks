using System;

namespace GraphicsEditor
{
    /// <summary>
    /// Static class with some math stuff
    /// </summary>
    static class LogicHelper
    {
        /// <summary>
        /// finds interval between 2 points
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public static double Interval(System.Drawing.Point p1, System.Drawing.Point p2)
        {
            return Math.Sqrt(Math.Pow(p1.X - p2.X, 2) + Math.Pow(p1.Y - p2.Y, 2));
        }

        /// <summary>
        /// finds interval between point and line
        /// </summary>
        /// <param name="line"></param>
        /// <param name="point"></param>
        /// <returns></returns>
        public static double IntervalBetweenPointAndLine(Line line, System.Drawing.Point point)
        {
            double x1 = line.GetXBegin(), 
                   x2 = line.GetXEnd(), 
                   y1 = line.GetYBegin(),
                   y2 = line.GetYEnd(), 
                   x3 = point.X, 
                   y3 = point.Y;
            double x4 = ((x2 - x1) * (y2 - y1) * ((x2 - x1) * (y2 - y1) * (y1 - y3) - 
                        Math.Pow(x2 - x1, 2) * x3 - Math.Pow(y2 - y1, 2) * x1)) /
                        ((-Math.Pow(x1 - x2, 2) - Math.Pow(y2 - y1, 2)) * (x2 - x1) *
                        (y2 - y1));
            double y4 = ((x1 - x2) * (x4 - x3) + y3 * (y2 - y1)) / (y2 - y1);
            return Math.Sqrt(Math.Pow(x4 - x3, 2) + Math.Pow(y4 - y3, 2));
        }
    }
}
