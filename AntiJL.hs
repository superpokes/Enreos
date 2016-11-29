-- file: ch04/InteractWith.hs
-- Save this in a source file, e.g. Interact.hs

import System.Environment (getArgs)

deleteComms :: String -> String
deleteComms [] = []
deleteComms st =
    let (pre, suf) = break isComm1 st
        (suf1,suf2) = break isComm2 st
    in pre ++ (deleteComms $ tail suf2)

isComm1 c = c == '['
isComm2 c = c == ']'

interactWith function inputFile outputFile = do
    input <- readFile inputFile
    writeFile outputFile (function input)
    
main = mainWith myFunction where 
    mainWith function = do
        args <- getArgs
        case args of
            [input,output] -> interactWith function input output
            _ -> putStrLn "error: exactly two arguments needed"
                                                  
    myFunction = deleteComms
