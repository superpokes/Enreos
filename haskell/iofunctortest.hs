import Data.Char
import Data.List
import Control.Applicative

--main = do 
--    line <- fmap (unwords . map (intersperse '-') . words) getLine
--    putStrLn line

--main = fmap putStrLn ((++) <$> getLine <*> getLine)
--main = return $ fmap putStrLn (Just "jj")
main = do 
    aah <- (++) <$> getLine <*> getLine
    print aah
