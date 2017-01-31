seqA :: Integer -> Integer
seqA n = inner n 3 2 1

inner n a2 a1 a0 | n == 0 = a0
                 | n == 1 = a1
                 | n == 2 = a2
                 | otherwise = inner (n - 1) (a2 + a1 - 2 * a0) a2 a1