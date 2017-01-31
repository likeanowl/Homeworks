sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x | x == 0 = (0,1)
              | x < 0 = sum'n'count (abs x)
              | otherwise = ((mysum 0 x), (mycount 0 x))

mysum :: Integer -> Integer -> Integer
mysum acc x | x > 0 = mysum (acc + x `mod` 10) (x `div` 10)
            | x == 0 = acc

mycount :: Integer -> Integer -> Integer
mycount acc x | x > 0 = mycount (acc + 1) (x `div` 10)
              | x == 0 = acc 