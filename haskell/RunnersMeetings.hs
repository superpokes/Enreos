-- https://codefights.com/arcade/code-arcade/spring-of-integration/Hb9Cppx4pCY4d8J5P
-- Some people run along a straight line in the same direction. They start simultaneously
-- at pairwise distinct positions and run with constant speed (which may differ from
-- person to person).
-- If two or more people are at the same point at some moment we call that a meeting. The
-- number of people gathered at the same point is called meeting cardinality.
-- For the given starting positions and speeds of runners find the maximum meeting
-- cardinality assuming that people run infinitely long. If there will be no meetings,
-- return -1 instead.

import Control.Arrow
import Data.Function (on)
import Data.Map.Strict (elems, filterWithKey, fromListWith)
import Data.Set (fromList, size, union)

runnersMeetings :: [Int] -> [Int] -> Int
runnersMeetings starts speeds =
    case elems $ fmap size counts of
        [] -> -1
        xs -> if maximum xs == 1 then -1 else maximum xs
    where
    positions = (zip `on` map fromIntegral) starts speeds
    intersections = map ((\[x, y] -> intersect x y) &&& fromList) (combinations 2 positions)
    counts = filterWithKey (\x _ -> not $ (isNaN x || isInfinite x)) $ fromListWith union intersections

intersect :: Fractional a => (a, a) -> (a, a) -> a
intersect (n, m) (n', m') = (n - n') / (m' - m)

combinations :: Int -> [a] -> [[a]]
combinations k xs = _combinations k (length xs) xs
    where
    _combinations 0 _ _ = [[]]
    _combinations _ 0 _ = []
    _combinations k l xs@(x:rest)
        | k < 0 = []
        | k < l = [x:ys | ys <- _combinations (k - 1) (l - 1) rest]
                    ++ _combinations k (l - 1) rest
        | k == l = [xs]
        | otherwise = []

