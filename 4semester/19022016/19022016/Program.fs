open Functions

[<EntryPoint>]

let main args = 
    printfn "factorial of %d = %d" 5 (factorial 5)
    printfn "4th fibbonacci number is %d" (fibbonacci 4)
    let list = [1; 2; 3; 4; 5]
    printfn "default list : %O" list
    printfn "reversed list : %O" (reverseList list)
    printfn "list of 2 pow's from 5 : %O" (powersOfTwo 5)
    0