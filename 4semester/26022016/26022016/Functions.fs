module Functions 

/// Digitals multiplication
let rec dMult n = 
    if n < 10 then n else (n % 10) * dMult (n / 10)

/// Index in list
let indVarInList list var =
    let rec innerRec ls v ind =
        match ls with
        | [] -> -1
        | h :: t -> if v = h then ind else innerRec t v (ind + 1)
    innerRec list var 0

/// Reverses list (helper function)
let reverseList list = 
    let rec recursiveReverse list tempList =
        match list with
        | [] -> tempList
        | head :: tail -> recursiveReverse tail (head :: tempList)
    recursiveReverse list []

/// Checking is string a palindrom
let pal str =
    let list = [for i in str -> i]
    let removeLast list = reverseList (reverseList list).Tail
    let rec innerRec list =
        match list with 
        | [] -> true
        | h :: [] -> true
        | h :: t -> if h = (reverseList t).Head then innerRec (removeLast t) else false
    innerRec list

/// Cheking is all elemets are different
let rec isAllDifferent list =
    match list with
    | [] -> false
    | h :: [] -> true
    | h :: t -> if h = t.Head then false else isAllDifferent t 
