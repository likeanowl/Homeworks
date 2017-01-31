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

     member this.getAll
        with get() = allComps
     
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

let mutable archComp = Computer("arch", false, 60)
let mutable win7Comp = Computer("windows", true, 99)
let mutable win8Comp = Computer("windows", false, 70)
let mutable compList = [|archComp; win7Comp; win8Comp |]
let mutable adjM = [| [|true; true; true|];
                      [|true; true; true|];
                      [|true; true; true|] |]
let mutable ln = LocalNetwork(adjM, compList)
printfn "%A" ln.getInfected
ln.step
printfn "%A" ln.getInfected
ln.step
printfn "%A" ln.getInfected
ln.step
printfn "%A" ln.getInfected
