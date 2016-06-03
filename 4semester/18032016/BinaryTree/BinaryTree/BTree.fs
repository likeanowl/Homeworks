open System
open System.Collections
open System.Collections.Generic

type TreeEnum<'a>(ls : list<'a>) =
    let fullList = if ls.IsEmpty then List.empty else ls.Head :: ls
    let mutable currentList = fullList
        
    interface IEnumerator<'a> with
        member this.Current
            with get() = currentList.Head :> obj
        member this.Current
            with get() = currentList.Head
        member this.MoveNext() =
            match currentList with
                | h :: t -> currentList <- t
                            not t.IsEmpty
                | [] -> false
        member this.Reset() = currentList <- fullList
        member this.Dispose() = ()

type BinaryTree<'a when 'a : comparison> = 
    | BinaryTree of 'a * BinaryTree<'a> * BinaryTree<'a>
    | Tip of ('a option)
        with
            member this.add value =
                match this with 
                | BinaryTree(node, left, right) -> if value > node then BinaryTree(node, left, right.add value)
                                                   elif value < node then BinaryTree(node, left.add value, right)
                                                   else BinaryTree(node, left, right)
                | Tip(node) -> match node with
                               | None -> Tip(Some(value))
                               | Some node -> if value > node then BinaryTree(node, Tip(None), Tip(Some(value)))
                                              elif value < node then BinaryTree(node, Tip(Some(value)), Tip(None))
                                              else BinaryTree(node, Tip(None), Tip(None))

            member this.isEmpty =
                match this with
                | BinaryTree(_) -> false
                | Tip(node) -> match node with
                               | Some _ -> false
                               | None -> true 
            
            member this.remove value =
                let mostLeftNode this =
                    let rec inRec tree acc =
                        match tree with
                            | BinaryTree(node, left, right) -> if node = inRec left node
                                                               then inRec right node
                                                               else inRec left node
                            | Tip(node) -> match node with
                                           | Some node -> node
                                           | None -> acc
                                                               
                    match this with
                    | BinaryTree(node, left, right) -> Some(inRec this node)
                    | Tip(node) -> match node with
                                   | None -> None
                                   | Some value -> Some value
                                    
                match this with
                | BinaryTree(node, left, right) -> if node < value then BinaryTree(node, left, right.remove value)
                                                   elif node > value then BinaryTree(node, left.remove value, right)
                                                   else match mostLeftNode right with
                                                        | None -> left
                                                        | Some value -> BinaryTree(value, left, right.remove value)   
                | Tip(node) -> match node with
                               | None -> Tip(None)
                               | Some value -> Tip(None)
            
            member this.contains value =
                match this with
                | BinaryTree(node, left, right) -> if value > node then right.contains value
                                                   elif value < node then left.contains value
                                                   else true
                | Tip(node) -> match node with
                               | None -> false
                               | Some nodeVal -> nodeVal = value

            member private this.convertToList =
                let rec inRec btree acc =
                    match btree with
                        | BinaryTree(value, left, right) -> let rightList = inRec right List.Empty
                                                            inRec left ((value :: rightList) @ acc)            
                        | Tip(node) -> match node with
                                           | None -> acc
                                           | Some value -> value :: acc
                this |> inRec <| List.empty

            interface IEnumerable<'a> with
                member this.GetEnumerator() =
                    (new TreeEnum<'a>(this.convertToList) :> IEnumerator<'a>)
                member this.GetEnumerator() =
                    (new TreeEnum<'a>(this.convertToList) :> IEnumerator)

let mutable bTree = BinaryTree.Tip(Some(3))
bTree <- bTree.add 4
bTree <- bTree.add 1
bTree <- bTree.add 2
bTree <- bTree.add 7
for x in bTree do printf "%A " x
printfn ""
bTree <- bTree.remove 2
for x in bTree do printf "%i " x
printfn ""
bTree <- bTree.remove 3
for x in bTree do printf "%i " x
printfn ""
printfn "%A" (bTree.contains 3)
printfn "%A" (bTree.contains 7)