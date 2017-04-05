-- https://projecteuler.net/problem=59
--
-- Each character on a computer is assigned a unique code and the preferred
-- standard is ASCII (American Standard Code for Information Interchange). For
-- example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
--
-- A modern encryption method is to take a text file, convert the bytes to
-- ASCII, then XOR each byte with a given value, taken from a secret key. The
-- advantage with the XOR function is that using the same encryption key on the
-- cipher text, restores the plain text; for example, 65 XOR 42 = 107,
-- then 107 XOR 42 = 65.
--
-- For unbreakable encryption, the key is the same length as the plain text
-- message, and the key is made up of random bytes. The user would keep the
-- encrypted message and the encryption key in different locations, and without
-- both "halves", it is impossible to decrypt the message.
--
-- Unfortunately, this method is impractical for most users, so the modified
-- method is to use a password as a key. If the password is shorter than the
-- message, which is likely, the key is repeated cyclically throughout the
-- message. The balance for this method is using a sufficiently long password
-- key for security, but short enough to be memorable.
--
-- Your task has been made easy, as the encryption key consists of three lower
-- case characters. Using cipher.txt (right click and 'Save Link/Target As...'),
-- a file containing the encrypted ASCII codes, and the knowledge that the plain
-- text must contain common English words, decrypt the message and find the sum
-- of the ASCII values in the original text.

{-# LANGUAGE OverloadedStrings #-}

import Data.Bits (xor)
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import Data.Function (on)
import Data.List (maximumBy)
import Data.Set (Set, fromAscList, member)
import Data.Ratio ((%), Ratio)
import Data.Text (splitOn, Text)
import Data.Text.Encoding (decodeUtf8)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Data.Word (Word8)
import System.Environment (getArgs)

-- | Transforms the imput file's text, that contains a list of comma-separated
--   numbers representing the ascii values for the characters in the encrypted
--   message, to a ByteString
listToChars :: Text -> ByteString
listToChars = BS.pack . map (fromIntegral . read . Text.unpack) . splitOn ","

-- | Returns a ratio of the amount of words in a certain text that exist in the
--   english language and the total amount of words in the text
percentOf :: Set Text -> [Text] -> Ratio Int
percentOf english = (%) <$> length . filter (`member` english) <*> length

-- | Applies the cycled xor key to a ByteString
applyKey :: [Word8] -> ByteString -> ByteString
applyKey key = BS.pack . zipWith xor (cycle key) . BS.unpack

keys :: [[Word8]]
keys = [[a, b, c] | a <- [0..255], b <- [0..255], c <- [0..255]]

mainWith :: FilePath -> FilePath -> IO ()
mainWith inputFile wordsFile = do
    input <- fmap listToChars (Text.readFile inputFile)
    english <- fmap (fromAscList . Text.words) (Text.readFile wordsFile)
    let decodes = map (decodeUtf8 . (`applyKey` input)) keys
        best = maximumBy (compare `on` (percentOf english . Text.words))
    Text.putStrLn $ best decodes


main :: IO ()
main = do
    args <- getArgs
    case args of
        [inputFile, wordsFile] -> mainWith inputFile wordsFile
        [inputFile] -> mainWith inputFile "words.txt"
        _ -> putStrLn "Usage: XorDecryption input words"
