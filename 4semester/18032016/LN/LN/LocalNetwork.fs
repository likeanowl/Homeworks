module LocalNetwork

open System
open Computer

type LocalNetwork(adjMatrix : array<array<bool>>, compList : array<Computer>) =
     let mutable infected = List.Empty

     let mutable allComps = compList

     let update (list : List<int>) index =
         if (compList.[index].isInf && not (List.exists ( (=) index) list))
         then index :: list
         else list

     member this.getInfected 
        with get() = infected
     
     member this.step = 
         let mutable currentInfected = List.Empty
         for i in [0 .. allComps.Length - 1] do
            if (allComps.[i].isInf && not (List.exists ((=) i) currentInfected))
            then 
                for j in [0 .. allComps.Length - 1] do 
                    if (i <> j && adjMatrix.[i].[j] && not (allComps.[j].isInf))
                    then allComps.[j].contaminate
                         infected <- update infected j
                         currentInfected <- update currentInfected j                        

