using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GraphicsEditor
{
    class UndoRedo
    {
        public UndoRedo()
        {
            states = new Stack<List<Line>>();
        }

        public void AddState(List<Line> list)
        {
            states.Push(list);
        }

        public List<Line> GetState()
        {
            if (states.Count != 0)
                return states.Pop();
            else return new List<Line>();
        }

        public bool IsEmpty()
        {
            return (states.Count == 0);
        }

        private Stack<List<Line>> states;

    }
}
