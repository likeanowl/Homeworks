using System.Collections.Generic;

namespace GraphicsEditor
{
    /// <summary>
    /// class for undo/redo realization
    /// </summary>
    class UndoRedo
    {
        /// <summary>
        /// initializes an empty stack of states of lines list
        /// </summary>
        public UndoRedo()
        {
            states = new Stack<List<Line>>();
        }

        /// <summary>
        /// adding a state
        /// </summary>
        /// <param name="list"></param>
        public void AddState(List<Line> list)
        {
            states.Push(list);
        }

        /// <summary>
        /// returning latest state
        /// </summary>
        /// <returns></returns>
        public List<Line> GetState()
        {
            if (states.Count != 0)
                return states.Pop();
            else return new List<Line>();
        }

        /// <summary>
        /// checking if stack is empty
        /// </summary>
        /// <returns></returns>
        public bool IsEmpty()
        {
            return (states.Count == 0);
        }

        private Stack<List<Line>> states;

    }
}
