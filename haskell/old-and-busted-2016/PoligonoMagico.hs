import Control.Monad

esPrimo :: Int -> Bool
esPrimo k = null [ x | x <- [2..isqrt k], k `mod`x  == 0]
    where isqrt = floor . sqrt . fromIntegral

adyacentesPrimos :: [Int] -> Bool
adyacentesPrimos (x:[]) = esPrimo x
adyacentesPrimos (x1:x2:[]) = esPrimo $ x1 + x2
adyacentesPrimos (x1:x2:xs) = let primación = esPrimo $ x1 + x2
    in if primación then adyacentesPrimos (x2:xs) else False

primeroUltimoPrimos :: [Int] -> Bool
primeroUltimoPrimos [] = False
primeroUltimoPrimos (x:[]) = esPrimo x
primeroUltimoPrimos (x:xs) = esPrimo $ x + (last xs)

todosDiferentes :: (Eq a) => [a] -> Bool
todosDiferentes [] = False
todosDiferentes [x] = True
todosDiferentes (x:xs) =
    let diferentex = and $ map (x/=) xs
    in if diferentex then todosDiferentes xs else diferentex

poligonosMagicos :: Int -> [[Int]]
poligonosMagicos n =
    let poligonosMagicos' :: [Int] -> [[Int]]
        poligonosMagicos' xs = do
            nuevo <- [2..n]
            guard $ adyacentesPrimos (nuevo:xs) && todosDiferentes (nuevo:xs)
            if length (nuevo:xs) == n then return (nuevo:xs) else poligonosMagicos' (nuevo:xs)

    in map reverse $ poligonosMagicos' [1]

main :: IO ()
main = print $ poligonosMagicos 6



    