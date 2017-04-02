import Control.Monad (replicateM, mapM_)
import System.Environment (getArgs)
import System.IO (hClose, hGetLine, hPutStrLn, IOMode(..), openFile)

teamLunch :: Int -> Int
teamLunch diners | diners <= 2 = (diners + 1) `div` 2
teamLunch diners = (diners - 1) `div` 2

format :: (Int, Int) -> String
format (i, diners) =
    let tables = teamLunch diners
    in "Case #" ++ show i ++ ": " ++ show tables

process :: String -> String -> IO ()
process inputPath outputPath = do
    inputFile <- openFile inputPath ReadMode
    outputFile <- openFile outputPath WriteMode
    cases <- fmap read (hGetLine inputFile)
    inputs <- replicateM cases (fmap read (hGetLine inputFile))
    mapM_ (hPutStrLn outputFile . format) (zip [1..] inputs)
    hClose inputFile
    hClose outputFile

main :: IO ()
main = do
    args <- getArgs
    case args of
        [i, o] -> process i o
        _ -> error "Usage: TeamLunch input_path output_path"
