module Shuffle 
( shuffle
) where

import Data.List hiding (insert)
import Data.Map hiding (foldl)
import System.Random

shuffleStep :: RandomGen g => (Map Int a, g) -> (Int, a) -> (Map Int a, g)
shuffleStep (m, gen) (i, x) = ((insert j x . insert i (m ! j)) m, gen')
    where
        (j, gen') = randomR (0, i) gen
 
shuffle :: RandomGen g => g -> [a] -> ([a], g)
shuffle gen [] = ([], gen)
shuffle gen l = 
    toElems $ foldl shuffleStep (initial (head l) gen) (numerate (tail l))
    where
        toElems (x, y) = (elems x, y)
        numerate = zip [1..]
        initial x gen = (singleton 0 x, gen)
