{-# LANGUAGE TupleSections #-}

import Control.Monad (replicateM, mapM_)
import Data.List (tails)
import System.Environment (getArgs)
import System.IO (hClose, hGetLine, hPutStrLn, IOMode(..), openFile)

data Move = R | L | RU | LU | RD | LD | D | U | K | P
    deriving (Eq, Read, Show)

combos :: [[Move]]
combos = [
    [L, LD, D, RD, R, P],
    [D, RD, R, P],
    [R, D, RD, P],
    [D, LD, L, K],
    [R, RD, D, LD, L, K]]

hadouken :: [Move] -> Int
hadouken = length . filter almostCombo . init . tails

almostCombo :: [Move] -> Bool
almostCombo moves = any (almost moves) combos

almost :: [Move] -> [Move] -> Bool
almost [] _ = True
almost (m:_) [c] = m /= c
almost (m:ms) (c:cs) = m == c && almost ms cs

readMoves :: String -> [Move]
readMoves = map read . wordsBy (== '-')

-- Data.List.Split
wordsBy :: (a -> Bool) -> [a] -> [[a]]
wordsBy f str =
    case break f str of
        ([], _:ys) -> wordsBy f ys
        (xs, []) -> [xs]
        (xs, _:ys) -> xs:wordsBy f ys
-- ---

format :: (Int, Int) -> String
format (i, count) = "Case #" ++ show i ++ ": " ++ show count

process :: String -> String -> IO ()
process inputPath outputPath = do
    inputFile <- openFile inputPath ReadMode
    outputFile <- openFile outputPath WriteMode
    cases <- fmap read (hGetLine inputFile)
    moves <- replicateM cases (fmap readMoves (hGetLine inputFile))
    mapM_ (hPutStrLn outputFile . format) (zip [1..] (map hadouken moves))
    hClose inputFile
    hClose outputFile

main :: IO ()
main = do
    args <- getArgs
    case args of
        [i, o] -> process i o
        _ -> error "Usage: program input_path output_path"
