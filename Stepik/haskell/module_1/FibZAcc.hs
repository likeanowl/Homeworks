fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n > 1 = fib (n - 1) 1 1
            | otherwise = (-1) ^ (abs n + 1) * fib (abs n - 1) 1 1

fib n f1 f2 | n == 0 = f1
            | n > 0 = fib (n - 1) f2 (f1 + f2)
            | otherwise = error "smth went wrong"