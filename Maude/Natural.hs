module Natural (Natural(Cero, Suce), esCero, igual, suma, producto) where

import Logico

data Natural = Cero | Suce Natural

instance Show Natural where
    show Cero = "0"
    show (Suce n) = show $ 1 + read (show n)

esCero :: Natural -> Booleano
esCero Cero = Verdadero
esCero (Suce n) = Falso

igual :: Natural -> Natural -> Booleano
igual Cero n = esCero n
igual (Suce n) Cero = Falso
igual (Suce n) (Suce m) = igual n m

suma :: Natural -> Natural -> Natural
suma Cero n = n
suma (Suce n) m = Suce $ suma n m

producto :: Natural -> Natural -> Natural
producto Cero n = Cero
producto (Suce n) m = suma m (producto n m)


uno = Suce Cero
dos = Suce uno
tres = Suce dos
cuatro = Suce tres
cinco = Suce cuatro
