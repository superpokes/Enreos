module Logico where

data Booleano = Verdadero | Falso deriving (Show)

no :: Booleano -> Booleano
no Verdadero = Falso
no Falso = Verdadero

y :: Booleano -> Booleano -> Booleano
Verdadero `y` Verdadero = Verdadero
_ `y` _ = Falso

o :: Booleano -> Booleano -> Booleano
Falso `o` Falso = Falso
_ `o` _ = Verdadero
