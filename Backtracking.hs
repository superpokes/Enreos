import Control.Monad

type Queen = (Int, Int)
type Queens = [Queen]

{-|
    Calcula las soluciones al problema de como colocar reinas en un tablero de tamaño n.
    Toma como parámetro el tamaño del tablero.
    Las soluciones se devuelven en una lista, cada solución expresada como una lista de las posiciones en las que hay
    que colocar a las reinas (el primer número es la posición de la primera reina en la primera fila, el segundo en la
    segunda fila, etc...)
-}
nQueens :: Int -> [Queens]
nQueens 0 = []
nQueens size = nQueens' 1 [ [(x,1)] | x <- [1..size]] where
    nQueens' stage s
        | stage < size = do
            qs <- s
            xq <- [1..size]
            guard $ possible (xq,stage + 1) qs
            nQueens' (stage + 1) $ return $ (xq,stage + 1):qs
        | otherwise = s
        where possible q qs = not $ or $ map (eats q) qs
              eats (x1, x2) (y1, y2) = x1 == y1 || abs(x1-y1) == abs(x2-y2) || x2 == y2

paint :: Queens -> IO ()
paint [] = return ()
paint (q:qs) = do
    putStrLn $ paintq q
    paint qs
    where paintq (x,y) = (take (2*(x-1)) (repeat ' ')) ++ "Q "

main :: IO ()
main = paint $ head $ nQueens 6
