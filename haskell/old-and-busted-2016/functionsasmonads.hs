import Control.Monad

addStuff :: Int -> Int
addStuff = do
    a <- (*2)
    b <- (+10)
    return (a+b)
    
main :: IO ()
main = print $ addStuff 3