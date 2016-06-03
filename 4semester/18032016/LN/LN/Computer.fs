module Computer

open System

type OS = string

let random = Random()

type Computer (os : OS, state, chance) = 
    let mutable isInfected = state
    let chanceOfInfection = chance
    member this.isInf
        with get() = isInfected
        and set(value) = isInfected <- value
    member this.OS
        with get() = os
    member this.contaminate = 
        let rand = random.Next(0, 100)
        isInfected <- rand < chanceOfInfection
