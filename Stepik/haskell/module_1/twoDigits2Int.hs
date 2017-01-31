import Data.Char
twoDigits2Int :: Char -> Char -> Int
twoDigits2Int x y = 
	if not (isNumber x) || not (isNumber y) then 100 else digitToInt x * 10 + digitToInt y