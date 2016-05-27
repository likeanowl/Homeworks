module Functions

let seqPlusMinus =
    let rec loop x =  seq {if x = 1 then yield x; yield! loop (x * (-1)); else yield x; yield! loop (x * (-1))}
    loop 1

let seqPlusMinusX a_seq = 
    let rec loop x = seq {yield x * a_seq[x]; yield! loop (x + 1)}
    loop 1

type Polynom<'a> =
    | Coefs of list<'a>

let powPoly (poly : Polynom<'a>) pow = 
    let rec loop (poly : Polynom<'a>) pow acc = 
        match poly with
        | Coefs list -> if pow > 0 then
                            loop poly (pow - 1) (list |> List.collect (fun x -> acc |> List.map (fun y -> x * y)))
                        else acc
    loop poly (pow + 1) [1]