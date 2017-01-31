fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci (-1) = 1
fibonacci (-2) = -1
fibonacci n = 
	if n > 1 then fibonacci (n - 1) + fibonacci (n - 2)
	else ((-1) ^ (abs n + 1)) * (fibonacci (abs n - 1) + fibonacci (abs n - 2))