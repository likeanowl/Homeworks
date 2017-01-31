module Functions

open System

type RoundBuilder(accur : int) =
    member this.Bind(x : float, f : float -> float) = Math.Round(f x, accur)
    member this.Return(x : float) = x

let parse str =
    let num = ref 0.0 
    let resOfParse = Double.TryParse(str, num)
    match resOfParse with
    | true -> Some !num
    | false -> None

type StringExprBuilder() =
    member this.Bind(str, f) =
        match parse str with
        | Some num -> f num
        | None -> None

    member this.Return(str) = Some str

let rounding accur = RoundBuilder(accur)
let strexpr = StringExprBuilder()


let res = rounding 3 {
        let! a = 2.0 / 12.0
        let! b = 3.5
        return a / b
    }

printfn "%A" res

let result1 = strexpr {
        let! x = "1"
        let! y = "2"
        let z = x + y
        return z
    }

printfn "%A" result1

let result2 = strexpr {
        let! x = "1"
        let! y = "Ъ"
        let z = x + y
        return z
    }

printfn "%A" result2
