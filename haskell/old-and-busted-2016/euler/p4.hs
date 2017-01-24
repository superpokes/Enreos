isPalindrome :: Integer -> Bool
isPalindrome n = word == reverse word where word = show n

results :: Integer -> [Integer]
results n = [x*y | x <- pool, y <- pool, isPalindrome (x*y)]
            where pool = takeWhile (<(10^n)) [1..]   
            
result n = foldl (max) 0 (results n)
