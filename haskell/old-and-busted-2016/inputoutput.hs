-- main = putStrLn "ahí va la bestia!"

-- main = do
--     putStrLn "Hello, what's your name?"
--     name <- getLine
--     putStrLn ("Ahí va la bestia, el " ++ name ++ ", qué pasa machine!")

-- main = do
--     line <- getLine
--     if null line
--         then return ()
--         else do
--             putStrLn $ reverseWords line
--             main
--             
-- reverseWords :: String -> String
-- reverseWords = unwords . map reverse . words

-- import Control.Monad
-- main = do
--     colors <- forM [1,2,3,4] (\a -> do
--         putStrLn $ "Which color do you associate with the number " ++ show a
--         getLine)
--     putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
--     mapM putStrLn colors

-- import Control.Monad
-- import Data.Char
-- main = forever $ do
--     putStr "Give me some input: "
--     l <- getLine
--     putStrLn $ map toUpper l

import Data.Char
main = do
    contents <- getContents
    putStr (map toUpper contents)
