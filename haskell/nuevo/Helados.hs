module Helados where

data Sabor = Chocolate | Fresa | Vainilla | Nata | Menta | Stracciatella | Pistacho | Limón | Naranja | Turrón | Caramelo
    deriving (Eq, Show, Read)
data Helado = Helado { sabor :: Sabor, tiempo :: Int , placer :: Int} deriving (Show)

compatible :: Helado -> Helado -> Bool
compatible _ _ = True -- ESTO ES UN CULO

compatible' :: Helado -> [Helado] -> Bool
compatible' a b = compatible a $ last b

secuenciaHelados :: [Helado] -> [Helado]
secuenciaHelados = id -- todo :)