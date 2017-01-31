integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b =
    let h = (b - a) / 1000 in 
    let summing n val x | n >= 0 = summing (n - 1) (val + (f x + f (x + h)) / 2 * h) (x + h)
                        | n == -1 = val
    in summing 999 0 a
