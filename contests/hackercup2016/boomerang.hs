-- boomerang.hs
-- Facebook Hacker Cup 2016: Qualification Round
-- Boomerang Constellation
-- author: Pablo Tato Ramos
import Data.List
import Control.Monad
import Data.Text (Text)
import Text.Read
import qualified Data.Text as T
import qualified Data.Text.IO as T

data Star = Star Int Int deriving (Show, Eq)
data Constellation = Constellation { common :: Star, end1 :: Star, end2 :: Star }
    deriving (Show)


instance Eq Constellation where
    (==) c1 c2 
        | end1 c1 == end1 c2 = common c1 == common c2 && end2 c1 == end2 c2
        | end1 c1 == end2 c2 = common c1 == common c2 && end2 c1 == end1 c2
        | end2 c1 == end1 c2 = common c1 == common c2 && end1 c1 == end2 c2
        | end2 c1 == end2 c2 = common c1 == common c2 && end1 c1 == end1 c2
        | otherwise = False


distance :: Star -> Star -> Double
distance (Star x1 y1) (Star x2 y2) = 
    let x = fromIntegral (x1 - x2)
        y = fromIntegral (y1 - y2)
    in sqrt $ (x ** 2) + (y ** 2)


boomerangs :: [Star] -> [Constellation]
boomerangs stars = foldr bWith [] stars where 
    bWith base acc = acc ++ foldr f [] stars
       where f x acc = acc ++ distinctConstellations base 
              (filter filterf stars)
              where filterf star = distance base x == distance base star &&
                     distance base star /= 0


howManyBoomerangs :: [Star] -> Int
howManyBoomerangs stars = foldl' bWith 0 stars
    where bWith acc base = acc + foldl' f 0 stars
            where f acc x = acc + (howManyDistinct $ length (filter ff stars))
                    where ff star = distance base x == distance base star 
                            && distance base star /= 0


howManyDistinct :: Int -> Int
howManyDistinct 0 = 0
howManyDistinct 1 = 0
howManyDistinct n = n - 1 + howManyDistinct (n - 1) 


distinctConstellations :: Star -> [Star] -> [Constellation]
distinctConstellations base [] = []
distinctConstellations base (star:[]) = []
distinctConstellations base (star1:star2:rest) = 
    (Constellation base star1 star2):(distinctConstellations base (star2:rest))
    

parseStar :: Text -> Star
parseStar text = let pieces = T.words text
    in Star (read $ T.unpack $ head pieces) (read $ T.unpack $ last pieces) 


parseStars :: Text -> [Star]
parseStars = map parseStar . T.lines


process :: [Text] -> [String]
process = addIndexes . map (show . length . boomerangs . parseStars)
    where addIndexes list = foldr (\x acc -> ("Case #" ++ 
            show (length list - length acc) ++ ": " ++ x):acc) [] list


firstSky = parseStars $ T.pack "0 0\n0 1\n0 3"
secondSky = parseStars $ T.pack "0 0\n0 1\n0 2\n0 3\n 0 4"


main :: IO ()
main = do
    n <- getLine
    input <- replicateM (read n) getNight
    let results = process input
    mapM_ putStrLn results
    where getNight = do
            n <- getLine
            input <- replicateM (read n) T.getLine
            return $ T.unlines input
