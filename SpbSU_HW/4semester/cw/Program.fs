
 //1

let listMin (list : List<'a>) =
    List.fold (fun acc i -> if i < acc then i else acc) list.Head list 
 
printfn "%A" (listMin [1; 2; -3; 10; -7; 3])

 
 //2
 
let printSq n =
    let array = Array2D.init n n (fun _ _ -> ' ')
    for i = 0 to n - 1 do
        for j = 0 to n - 1 do
            if i = 0 || j = 0 || j = (n - 1) || i = (n - 1) then Array2D.set array i j '*' else Array2D.set array i j ' '
    for i = 0 to n - 1 do
        for j = 0 to n - 1 do
            printf "%c" array.[i, j]
        printfn ""
 
printSq 4
//3
 
type queue<'a> =
    | Queue of 'a list * 'a list
    with
        static member empty = Queue([], [])

        member q.enqueue e = 
            match q with
            | Queue(fs, bs) -> Queue(e :: fs, bs)

        member q.dequeue = 
            match q with
            | Queue([], []) -> failwith "Empty"
            | Queue(ht, h :: t) -> h, Queue(ht, t)
            | Queue(ht, []) -> 
                let ss = List.rev ht
                ss.Head, Queue([], ss.Tail)

let mutable q = queue.Queue([], [])
q <- q.enqueue 1
q <- q.enqueue 2
q <- q.enqueue 3
let a = q.dequeue
printfn "%A" a
