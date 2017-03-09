{-# LANGUAGE OverloadedStrings #-}
-- | Dumb Dumb Dumb
module Main where

import System.Environment (getArgs)
import Data.List (group, sort, maximumBy)
import Data.Char (toUpper)
import Control.Arrow

import qualified Data.ByteString as B
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.IO as T

type Text = T.Text
type ByteString = B.ByteString

-- | I Love Point Free
mostUsedWord :: Text -> Text
mostUsedWord =
    fst . maximumBy (\a b -> snd a `compare` snd b) . map (head &&& length) .
    group . sort . T.words . T.toUpper

-- | Apply Data.Text.Encoding functions according to specified encoding.
decode :: String
       -- ^ The encoding to use. Accepted values are (case-insensitive): Latin1,
       --   Latin-1, ISO-8859-1, UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE,
       --   ASCII
       --   If an unrecognised encoding is supplied, utf-8 will be used as
       --   default.
       -> ByteString
       -- ^ The bytestring to decode
       -> Text
       -- ^ A decoded bytestring
decode enc = case map toUpper enc of
    "LATIN1" -> T.decodeLatin1
    "LATIN-1" -> T.decodeLatin1
    "ISO-8859-1" -> T.decodeLatin1
    "UTF-16LE" -> T.decodeUtf16LE
    "UTF-16BE" -> T.decodeUtf16BE
    "UTF-32LE" -> T.decodeUtf32LE
    "UTF-32BE" -> T.decodeUtf32BE
    _ -> T.decodeUtf8

main :: IO ()
main = do
    args <- getArgs
    case args of
        [inputFile, encoding] -> printResult inputFile encoding
        [inputFile] -> printResult inputFile "utf-8"
        _ -> putStrLn "please enter input file and optional encoding"
    where
        printResult inpf enc = do
            input <- B.readFile inpf
            T.putStrLn (mostUsedWord $ decode enc input)
