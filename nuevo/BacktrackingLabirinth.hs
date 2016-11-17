data Casilla = Libre | Ocupada deriving (Show)
data Laberinto = Laberinto [[Casilla]]

getCasilla :: Posicion -> Laberinto -> Casilla
getCasilla (x,y) (Laberinto cs) = cs !! y !! x

type Posicion = (Int,Int)

arriba = (0,-1)
abajo = (0,1)
izquierda = (-1,0)
derecha = (0,1)

lab = Laberinto
    [[Libre,   Libre,   Ocupada],
     [Ocupada, Libre,   Libre],
     [Ocupada, Ocupada, Libre]]

probar :: Laberinto -> Posicion -> Posicion -> Bool
probar (Laberinto cs) (x,y) (x',y')
    | x == x' && y == y' = True
    | otherwise =

main :: IO ()
main = print $ getCasilla (3,2) lab