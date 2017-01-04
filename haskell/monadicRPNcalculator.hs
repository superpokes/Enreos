import Data.List
import Control.Monad

solveRPN :: String -> Maybe Double
solveRPN st = do
    [result] <- foldM rpnf [] (words st)
    return result 
    where
        rpnf :: [Double] -> String -> Maybe [Double]
        rpnf (x:y:ys) "*" = return $ (x * y):ys
        rpnf (x:y:ys) "+" = return $ (x + y):ys
        rpnf (x:y:ys) "-" = return $ (y - x):ys
        rpnf xs nstring = liftM (:xs) (mbyread nstring) where
            mbyread st = case reads st of [(x,"")] -> Just x
                                          _ -> Nothing
    
main :: IO ()
main = print $ solveRPN "+ *"
