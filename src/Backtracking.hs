module Backtracking where

{-|
    Calcula las soluciones al problema de como colocar reinas en un tablero de tamaño n.
    Toma como parámetro el tamaño del tablero.
    Las soluciones se devuelven en una lista, cada solución expresada como una lista de las posiciones en las que hay
    que colocar a las reinas (el primer número es la posición de la primera reina en la primera fila, el segundo en la
    segunda fila, etc...)
-}
--nreinas :: Int -> [[Int]]
--nreinas 0 = []
--nreinas 1 = [[1]]
--nreinas size =
--    nreinas' 2 $ map (:[]) [1..size] -- [ [x] | x <- [1..size]]
--    where
--        nreinas' stage solutions =
--            let
--                possible (new:solution) =
--                    fst $ foldl possiblef (True, stage - 1) solution
--                    where
--                        possiblef (a,b) x =
--                            if not a || x == new || abs(x-new) == abs(b-stage)
--                            then (False, b - 1)
--                            else (a, b - 1)
--                candidates =
--                    [ esto:lootro | esto <- [1..size], lootro <- solutions] --(:) <$> [1..size] <*> solutions
--            in
--                if stage < size
--                then nreinas' (stage + 1) $ filter possible candidates
--                else filter possible candidates

--type Reina = (Int, Int)
--type Reinas = [Reina]
--nreinas :: Int -> [Reinas]
--nreinas 0 = []
--nreinas n = do
--    reinas <- todasReinas
--
--    where
--        todasReinas = do
--            x <- [1..n]
--            y <- [1..n]
--            return (x,y)

--import Control.Monad
--
--type Queen = (Int, Int)
--type Queens = [Queen]
--nQueens :: Int -> [Queens]
--nQueens 0 = []
--nQueens n =
--    nQueens' initial
--    where
--        initial = do
--            x <- [1..n]
--            return (x, 1)
--        nQueens' :: Queens -> [Queens]
--        nQueens' stage = do
--            xpos <- [1..n]
--            guard $ possible (xpos, nextlevel)
--            if nextlevel == n then return (xpos, nextlevel) else nQueens' $ return (xpos, nextlevel)
--            where
--                nextlevel = (snd $ head stage) + 1
--                possible :: Queens -> Bool
--                possible ((x,y):solution) =
--                    fst $ foldl possiblef (True, nextlevel - 1) solution
--                    where
--                        possiblef (a,b) x =
--                            if not a || x == new || abs(x-new) == abs(b-nextlevel)
--                            then (False, b - 1)
--                            else (a, b - 1)

import Control.Monad
type Queen = (Int, Int)
type Queens = [Queen]

eats :: Queen -> Queen -> Bool
eats (x1, x2) (y1, y2) = x1 == y1 || x2 == y2 || abs(x1-y1) == abs(x2-y2)

possible :: Queen -> Queens -> Bool
possible _ [] = True
possible q qs = not $ or $ map (eats q) qs

stage :: [Queens] -> Int
stage [] = 0
stage s = maximum $ map snd $ head s

nextStage :: Int -> [Queens] -> [Queens]
nextStage size [] = nextStage size $ [ [(x,1)] | x <- [1..size]]
nextStage size s =
    if currStage < size
    then do
        qs <- s
        xq <- [1..size]
        guard $ possible (xq,currStage + 1) qs
        nextStage size $ return ((xq,currStage + 1):qs)
    else s
    where currStage = stage s

paint :: Queens -> IO ()
paint [] = return ()
paint (q:qs) = do
    putStrLn $ paintq q
    paint qs
    where paintq (x,y) = (take (2*(x-1)) (repeat ' ')) ++ "Q "

--main :: IO ()
--main = print $ nQueens 4
