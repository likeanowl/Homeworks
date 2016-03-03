open Functions

// Learn more about F# at http://fsharp.net
// See the 'F# Tutorial' project for more help.
[<EntryPoint>]
let main argv = 
    printfn "Multiplication of all digits in %d = %d" 0 (dMult 0)
    printfn "Multiplication of all digits in %d = %d" 10 (dMult 10)
    printfn "Multiplication of all digits in %d = %d" 1234 (dMult 1234)
    let list = [1; 2; 3; 4; 5]
    printfn "Index of %d in %O is : %d" 3 list (indVarInList list 3)
    let str = "abcda"
    printfn "Is %s a palindrom? %b" str (pal str)
    printfn "Is all elements of %O are different? %b" list (isAllDifferent list)
    0