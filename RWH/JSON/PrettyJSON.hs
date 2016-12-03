module PrettyJSON where

import RWH.JSON.SimpleJSON

renderJValue :: JValue -> Doc
renderJValue (JBool True)  = text "true"
renderJValue (JBool False) = text "false"
renderJValue JNull         = text "null"
renderJValue (JNumber num) = double num
renderJValue (JString str) = string str

data Doc = ToBeDefined deriving (Show)

string :: String -> Doc
string = enclose '"' '"' . hcat . map oneChar

text :: String -> Doc
text str = undefined

double :: Double -> Doc
double num = undefined

enclose :: Char -> Char -> Doc -> Doc
enclose left right x = char left <> x <> char right

(<>) :: Doc -> Doc -> Doc
a <> b = undefined

char :: Char -> Doc
char c = undefined

hcat :: [Doc] -> Doc
hcat xs = undefined

oneChar :: Char -> Doc
oneChar c = case lookup c simpleEscapes of
              Just r -> text r
              Nothing | mustEscape c -> hexEscape c
                      | otherwise    -> char c
  where mustEscape c = c < ' ' || c == '\x7f' || c > '\xff'

simpleEscapes :: [(Char, String)]
simpleEscapes = zipWith ch "\b\n\f\r\t\\\"/" "bnfrt\\\"/"
    where ch a b = (a, ['\\',b])

smallHex :: Int -> Doc
smallHex x = text "\\u"
          <> text (replicate (4 - length h) '0')
          <> text h
    where h = showHex x ""
