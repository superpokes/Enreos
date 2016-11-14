type Trabajador = [Int]
type Tabla = [Trabajador]

input = [
    [1, 5, 1, 5],
    [1, 1, 2, 2],
    [1, 3, 1, 2],
    [1, 1, 4, 1]
    ]

getTrabajador :: Tabla -> Int -> [Int]
getTrabajador t n = t !! n

{-|
    :(
-}
resolver :: Tabla -> [Int]
resolver tabla = resolver' 0 [] where
    laststage = length $ head tabla
    resolver' stage maxeff

main :: IO ()
main = print ":)"