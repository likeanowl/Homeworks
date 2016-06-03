open System.Threading

let threads (array : int[]) (result : int ref) = 
    [
        for i in 0 .. 99 -> new Thread(ThreadStart(fun _ ->
            for j in i * 10000 .. (i + 1) * 10000 - 1 do
                    result := !result + array.[j])
                )
    ]

let array = Array.init(1000000) (fun i -> 1)
let result = ref 0

let thrds = threads array result

thrds |> List.map (fun (thread : Thread) -> thread.Start()) |> ignore
thrds |> List.map (fun (thread : Thread) -> thread.Join()) |> ignore

printfn "Result : %A" !result