doubleFact :: Integer -> Integer
doubleFact n = if n == 1 || n == 0 then 1 else n * doubleFact (n - 2)