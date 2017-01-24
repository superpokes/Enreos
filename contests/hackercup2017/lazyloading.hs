import Control.Monad
import Data.List

lazyLoading :: [Int] -> Int
lazyLoading [] = 0
lazyLoading items = lazyLoading' sortedItems
    where sortedItems = sort items
          lazyLoading' :: [Int] -> Int
          lazyLoading' [] = 0
          lazyLoading' items' =
              let bigOne = last items'
                  takenItems = foldl (\acc x -> if sum acc < 50 then x:acc else acc) [bigOne] (init items)
              in if sum takenItems < 50
                 then 0
                 else 1 + lazyLoading' (drop (length takenItems - 1) (init items'))




printDay :: (Int,[Int]) -> IO ()
printDay (index,day) = putStrLn $ "Case #" ++ show index ++ ": " ++ show (lazyLoading day)

main :: IO ()
main = do
    dayAmount <- getLine
    days <- replicateM (read dayAmount) readDay
    mapM_ printDay (calcIndex $ map (map read) days)
    where readDay = do
            itemAmount <- getLine
            replicateM (read itemAmount) getLine
          calcIndex xs = foldr (\x acc -> (length xs - length acc,x):acc) [] xs
