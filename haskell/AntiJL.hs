#! /usr/bin/runghc
{-
    Elimina los comentarios humorísticos de los apuntes del Juanlu, siempre y
    cuando cumpla sus propias reglas de sintaxis (que son meterlos entre
    corchetes)
-}

import System.Environment (getArgs)

-- TODO: THIS FUNCTION IS CURRENTLY NOT TAIL-RECURSIVE, REWRITE IT
deleteComments :: String -> String
deleteComments [] = []
deleteComments st =
    let (pre,_) = break (\c -> c == '[') st
        (_,suf) = break (\c -> c == ']') st
    in pre ++ (deleteComments $ tail suf)

{-
    Este script es bastante reusable, para cualquier vez que necesite tomar un
    archivo de entrada, modificarlo directamente y guardar el resultado en un
    archivo, este esqueleto es perfecto. Basta con sustituir la función
    deleteComments con la que sea necesaria. El script tomará dos argumentos
    al ejecutarlo, el primero es el archivo de entrada, y el segundo el archivo
    de salida
-}

interactWith function inputFile outputFile = do
    input <- readFile inputFile
    writeFile outputFile (function input)

main = mainWith myFunction where
    mainWith function = do
        args <- getArgs
        case args of
            [input,output] -> interactWith function input output
            _ -> putStrLn "error: exactly two arguments needed"

    myFunction = deleteComments
