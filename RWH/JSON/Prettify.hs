module RWH.JSON.Prettify where

import RWH.JSON.SimpleJSON

data Doc = ToBeDefined deriving (Show)

string :: String -> Doc
string = enclose '"' '"' . hcat . map oneChar

text :: String -> Doc
text str = undefined

double :: Double -> Doc
double num = undefined

enclose :: Char -> Char -> Doc -> Doc
enclose left right x = char left <> x <> char right 
