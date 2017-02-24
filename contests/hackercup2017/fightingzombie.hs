-- unfinished
import Control.Monad
import Data.List
import Numeric

type Zombie = Int
data Spell = Spell { rolls :: Int, sides :: Int, offset :: Int }
    deriving (Show)

minSpellDamage :: Spell -> Int
minSpellDamage spell = rolls spell + offset spell

maxSpellDamage :: Spell -> Int
maxSpellDamage spell = sides spell * rolls spell + offset spell

possibleOutcomes :: Spell -> Int
possibleOutcomes spell = product (replicate (rolls spell) (sides spell))

probabilityOf :: Int -> Spell -> Int
probabilityOf n spell
    | n < minSpellDamage spell = 0
    | n == minSpellDamage spell || rolls spell == 0 = 1
    | otherwise = sum [probabilityOf (n-x) spell{ rolls = rolls spell - 1 }  | x <- [1..sides spell]]

probabilityOfOrBigger :: Int -> Spell -> Double
probabilityOfOrBigger n spell = fromIntegral (probabilityOf n spell) / fromIntegral (possibleOutcomes spell)

parseZombie :: String -> Zombie
parseZombie = read . head . words

parseSpell :: String -> Spell
parseSpell source = Spell (read rollsS) (read sidesS) offsetN
    where (rollsS,rest) = break (== 'd') source
          (sidesS,offsetS) = break (`elem` "+-") (tail rest)
          offsetN
            | null offsetS = 0
            | head offsetS == '+' = read (tail offsetS)
            | otherwise = read offsetS

maxPercentOfKill :: Zombie -> [Spell] -> Double
maxPercentOfKill zombie spells = maximum $ map (probabilityOfOrBigger zombie) spells

formatFloatN :: Double -> Int -> String
formatFloatN floatNum numOfDecimals = showFFloat (Just numOfDecimals) floatNum ""

process :: (Int,(String,String)) -> String
process (index,(zombieS,spellsS)) = let
    zombie = parseZombie zombieS
    spells = map parseSpell (words spellsS)
    in "Case #" ++ show index ++ ": " ++
       formatFloatN (maxPercentOfKill zombie spells) 6

main :: IO ()
main = do
    zombieAmount <- getLine
    inputs <- replicateM (read zombieAmount) (do zombie <- getLine
                                                 spells <- getLine
                                                 return (zombie,spells))
    mapM_ (putStrLn . process) (calcIndex inputs)
    where calcIndex xs = foldr (\x acc -> (length xs - length acc,x):acc) [] xs
