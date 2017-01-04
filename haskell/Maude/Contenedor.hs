module Contenedor where

data Contenedor a = Crear | Archivar (Contenedor a) a deriving (Show)

recuperar :: Contenedor a -> a
recuperar Crear = error ":)"
recuperar (Archivar c x) = x
