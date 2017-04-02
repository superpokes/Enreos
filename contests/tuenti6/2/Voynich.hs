{-# LANGUAGE TupleSections #-}

import Control.Monad (replicateM, mapM_)
import Data.Function (on)
import Data.List (intercalate, sortBy)
import Data.Map.Strict (fromListWith, toList)
import System.Environment (getArgs)
import System.IO (hClose, hGetLine, hPutStrLn, IOMode(..), openFile)

voynich :: String -> [Int] -> [(String, Int)]
voynich corpus [start, end] = take 3 $ sortBy (flip compare `on` snd) frequencies
    where
        relevant = drop (start - 1) $ take end $ words corpus
        frequencies = toList $ fromListWith (+) (map (,1) relevant)


format :: (Int, [(String, Int)]) -> String
format (i, frequent) =
    let
        msgWord (w, fr) = w ++ " " ++ show fr
        msg = intercalate "," (map msgWord frequent)
    in
        "Case #" ++ show i ++ ": " ++ msg

process :: String -> String -> IO ()
process inputPath outputPath = do
    inputFile <- openFile inputPath ReadMode
    outputFile <- openFile outputPath WriteMode
    corpus <- readFile "corpus.txt"
    cases <- fmap read (hGetLine inputFile)
    intervals <- replicateM cases (fmap (map read . words) (hGetLine inputFile))
    mapM_ (hPutStrLn outputFile . format) (zip [1..] (map (voynich corpus) intervals))
    hClose inputFile
    hClose outputFile

main :: IO ()
main = do
    args <- getArgs
    case args of
        [i, o] -> process i o
        _ -> error "Usage: program input_path output_path"
