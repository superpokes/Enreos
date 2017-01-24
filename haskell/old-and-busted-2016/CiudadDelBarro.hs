-- CiudadDelBarro.hs
-- author: Pablo Tato Ramos
-- Movidas de ADA (Nov. 2016)
-- Un algoritmo que se puede hacer voraz, pero con backtracking, porque doy
-- una cantidad de asco abrumadora. Lección: piensa antes de picar código.
import Control.Monad

type Node a = a
type Edge a = (Int,(Node a,Node a))
data Graph a = Graph { nodes :: [Node a], edges :: [Edge a] } deriving (Show)

test_graph = Graph { nodes = [1,2,3,4,5], edges = [(1,(1,2)),(3,(1,4)),(2,(2,4)),(8,(4,3)),(1,(5,4))] } :: Graph Int

adjacent :: (Eq a) => Graph a -> Node a -> [Node a]
adjacent (Graph nodes edgs) n = do
    edge <- (map snd edgs)
    guard $ sides edge
    return $ other edge
    where sides e = n == (fst e) || (n == (snd e))
          other e = if fst e == n then snd e else fst e

sumEdges :: Graph a -> Int
sumEdges (Graph ns es) = foldl (\acc x -> fst x + acc) 0 es

{-| Paso de como que documentar esta mierda, una basura asquerosa sabes -}
testVisited :: Eq a => Maybe ([a],[a]) -> (a,a) -> Maybe ([a],[a])
testVisited Nothing _ = Nothing
testVisited (Just (visit,novisit)) (x1,x2)
    | está1 && está2 = Nothing
    | está1 = Just (x2:visit, filter (/= x2) novisit)
    | está2 = Just (x1:visit, filter (/= x1) novisit)
    | otherwise = Just (x1:x2:visit, filter (/= x1) $ filter (/= x2) novisit)
    where está1 = x1 `elem` visit
          está2 = x2 `elem` visit


isValid :: Graph Int -> Bool
isValid (Graph ns es) = foldl testVisited (Just ([],ns)) (map snd es) /= Nothing


isComplete :: Graph Int -> Bool
isComplete (Graph ns es) = case foldl testVisited (Just ([],ns)) (map snd es) of
    Nothing -> False
    Just (_, ns) -> not $ null ns


edgeEstá :: Edge Int -> [Edge Int] -> Bool
edgeEstá (_,e) es = or $ map (igual e) (map snd es)
    where igual (x1,x2) (y1,y2) = (x1 == y1 && x2 == y2) || (x1 == y2 && x2 == y1)

justAdd :: Graph Int -> Edge Int -> Graph Int
justAdd (Graph ns es) (d,(s1,s2))
    | está1 && está2 = Graph ns es'
    | está1 = Graph (s2:ns) es'
    | está2 = Graph (s1:ns) es'
    | otherwise = Graph (s1:s2:ns) es'
    where e = (d,(s1,s2))
          es' = if e `edgeEstá` es then es else e:es
          está1 = s1 `elem` ns
          está2 = s2 `elem` ns

ciudadDelBarro :: Graph Int -> Graph Int
ciudadDelBarro (Graph ns es) =
    let ciudadDelBarro' :: Graph Int -> [Graph Int]
        ciudadDelBarro' (Graph ns' es') = do
            e <- es
            guard $ isValid $ justAdd (Graph ns' es') e
            return $ justAdd (Graph ns' es') e
        completeSolutions = filter isComplete (ciudadDelBarro' (Graph [] []))
    in snd $ foldl (\(max,maxg) x -> if sumEdges x > max then (sumEdges x,x) else (max,maxg)) (0,(Graph [] [])) completeSolutions

main :: IO ()
main = print $ ciudadDelBarro test_graph
