module Bolsa where

import Natural

data Bolsa a = Crear | Poner (Bolsa a) a deriving (Show)

esVacia :: Bolsa a -> Bool
esVacia Crear = True
esVacia (Poner b e) = False

retirar :: Bolsa a -> Bolsa a
retirar Crear e = Crear

cuantos :: (Eq a) => Bolsa a -> a -> Int
cuantos Crear e = 0
cuantos (Poner b f) e = 
    if e == a 
    then 1 + 


