-- Calcula los factores de un entero y los devuelve como una lista
-- de enteros
factors :: Integer -> [Integer]
factors 0 = []
factors 1 = []
factors n = let smaller = head [x | x <- [2..n], n `mod` x == 0]
                rest = factors (n `div` smaller)
            in smaller:rest
            
-- Primera parte de calcular el Mínimo Común Múltiplo (mcm)
-- Une 2 listas de factores en una sola que contiene el factor
-- con el exponente más alto y todos los únicos
mcm' :: [Integer] -> [Integer] -> [Integer]
mcm' xs [] = xs
mcm' [] xs = xs
mcm' (x:xs) (y:ys) = case compare x y of EQ -> x:(mcm' xs ys)
                                         GT -> y:(mcm' (x:xs) ys)
                                         LT -> x:(mcm' xs (y:ys))

-- Une n listas en vez de solo 2
mcm'' :: [[Integer]] -> [Integer]
mcm'' [] = []
mcm'' (x:xs) = (mcm' x (mcm'' xs))

-- Calcula el mínimo común múltiplo de unos cuantos enteros
mcm :: [Integer] -> Integer
mcm [] = 1
mcm xs = foldl (*) 1 (mcm'' $ map factors xs)

answer = mcm [1..20]
