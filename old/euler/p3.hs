thenumber = 600851475143

prime :: Integer -> Bool
prime 0 = False
prime 1 = True
prime x = foldl (\acc n -> if acc then not (x `mod` n == 0) else False) True [2..(x-1)]

primeFactors :: Integer -> [Integer]
primeFactors n = primeFactors' 2 n
                 
primeFactors' :: Integer -> Integer -> [Integer]
primeFactors' _ 0 = []
primeFactors' _ 1 = []
primeFactors' initial n = let smaller = head [x | x <- [initial..], n `mod` x == 0, prime x]  
                              rest = primeFactors' smaller (n `div` smaller) 
                          in smaller:rest
