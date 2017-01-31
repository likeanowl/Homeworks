module Tree

type Tree<'a> = 
    | Tree of 'a * Tree<'a> * Tree<'a>
    | Tip of 'a