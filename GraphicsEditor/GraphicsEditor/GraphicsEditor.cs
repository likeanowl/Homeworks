using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GraphicsEditor
{
    public partial class mainForm : Form
    {
        public mainForm()
        {
            InitializeComponent();
            lines = new Lines();
        }

        public void DrawingAreaMouseDown(object sender, MouseEventArgs e)
        {
            if (drawing)
            {
                line = new Line(new Point(e.X, e.Y), new Point(e.X+3, e.Y+3));
                mouseDown = true;
                undo.AddState(lines.GetState());
                drawingArea.Invalidate();
            }
            if (changing && selected)
            {
                mouseDown = true;
                if (LogicHelper.Interval(new Point(line.GetXEnd(), line.GetYEnd()),
                        new Point(e.X, e.Y)) <= 5)
                {
                    undo.AddState(lines.GetState());
                    lineEndDragging = true;
                }
                else
                if (LogicHelper.Interval(new Point(line.GetXBegin(), line.GetYBegin()),
                        new Point(e.X, e.Y)) <= 5)
                {
                    undo.AddState(lines.GetState());
                    lineStartDragging = true;
                }
                else
                {
                    selected = false;
                    drawingArea.Invalidate();
                }
            }
            else
            if (changing && !selected)
            {
                Line newLine = lines.FindNearestLine(new Point(e.X, e.Y));
                if (newLine != null)
                {
                    line = newLine;
                    selected = true;
                    drawingArea.Invalidate();
                }
            }
        }

        public void DrawingAreaMouseUp(object sender, MouseEventArgs e)
        {
            mouseDown = false;
            if (drawing)
            {
                lines.AddLine(line);
            }
            if (changing && selected)
            {
                if (lineEndDragging)
                {
                    for (int i = 0; i < lines.Count; i++)
                    {
                        if (lines[i].GetXBegin() == line.GetXBegin() &&
                                lines[i].GetYBegin() == line.GetYBegin())
                            lines[i] = line;
                    }
                    lineEndDragging = false;
                }
                else
                if (lineStartDragging)
                {
                    for (int i = 0; i < lines.Count; i++)
                    {
                        if (lines[i].GetXEnd() == line.GetXEnd() &&
                                lines[i].GetYEnd() == line.GetYEnd())
                            lines[i] = line;
                    }
                    lineStartDragging = false;
                }
            }
        }

        public void DrawingAreaMouseMove(object sender, MouseEventArgs e)
        {
            if (mouseDown)
            {
                if (drawing)
                {
                    line.ChangeLineEnd(new Point(e.X, e.Y));
                    drawingArea.Invalidate();
                }
                if (changing && selected)
                {
                    if (lineEndDragging)
                    {
                        line.ChangeLineEnd(new Point(e.X, e.Y));
                    }
                    if (lineStartDragging)
                    {
                        line.ChangeLineStart(new Point(e.X, e.Y));
                    }
                    drawingArea.Invalidate();
                }
            }
        }

        public void DrawingAreaPaint(object sender, PaintEventArgs e)
        {
            lines.Draw(e);
            if (mouseDown && drawing)
                line.Draw(e);
            if (changing && selected && mouseDown)
            {
                line.Draw(e);
            }
            if (changing && selected)
            {
                e.Graphics.DrawRectangle(new Pen(Color.Black),
                    new Rectangle(line.GetXBegin(), line.GetYBegin(), 4, 4));
                e.Graphics.DrawRectangle(new Pen(Color.Black),
                    new Rectangle(line.GetXEnd(), line.GetYEnd(), 4, 4));
            }
        }

        public void BtnClick(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            switch (btn.Text)
            {
                case ("Undo"):
                    if (!undo.IsEmpty())
                    {
                        selected = false;
                        redo.AddState(lines.GetState());
                        lines.SetState(undo.GetState());
                        drawingArea.Invalidate();
                    }
                    break;
                case ("Redo"):
                    if (!redo.IsEmpty())
                    {
                        selected = false;
                        undo.AddState(lines.GetState());
                        lines.SetState(redo.GetState());
                        drawingArea.Invalidate();
                    }
                    break;
                case ("Draw"):
                    drawing = true;
                    changing = false;
                    selected = false;
                    break;
                case ("Select"):
                    drawing = false;
                    changing = true;
                    break;
                case ("Delete"):
                    undo.AddState(lines.GetState());
                    if (selected)
                    { 
                        lines.DeleteLine(line);
                    }
                    selected = false;
                    drawingArea.Invalidate();
                    break;
            }
        }

        private bool lineEndDragging;
        private bool lineStartDragging;
        private bool selected = false;
        private UndoRedo undo = new UndoRedo();
        private UndoRedo redo = new UndoRedo();
        private bool changing;
        private bool drawing;
        private bool mouseDown = false;
        private Line line;
        private Lines lines;
    }
}
