module Functions

/// Factorial
let rec factorial x =
    if x = 0 then 1 else x * factorial (x - 1)

/// Fibbonachi numbers
let rec fibbonacci x = 
    if x = 1 || x = 0 then 1 else fibbonacci (x - 2) + fibbonacci (x - 1)

/// Reverses list
let reverseList list = 
    let rec recursiveReverse list tempList =
        match list with
        | [] -> tempList
        | head :: tail -> recursiveReverse tail (head :: tempList)
    recursiveReverse list []

/// Ivolutes 2 in power
let rec power pow = 
    if pow = 0 then 1 else 2 * power (pow - 1)

/// Creates consequence of 2 pow's 
let powersOfTwo startPow =
    List.init 5 (fun i -> power (startPow + i))

