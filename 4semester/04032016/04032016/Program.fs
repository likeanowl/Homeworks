open Functions
open System
open System.Collections

let main = 
    let list = [1; 2; 3; 4; 5]
    printfn "%d" (indexOfMaxSum list)
    printfn "%d" (evenNumbersCountMap list)
    printfn "%d" (evenNumbersCountFilter list)
    printfn "%d" (evenNumbersCountFold list)
    let primeNumbersSeqEnumerator = primeNumbersSeq.GetEnumerator()
    while primeNumbersSeqEnumerator.MoveNext() do
        printfn "%i" primeNumbersSeqEnumerator.Current
    Console.ReadKey(true) |> ignore
    0 // return an integer exit code

