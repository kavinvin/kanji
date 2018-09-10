import Data.List hiding (insert)
import Data.Map hiding (foldl)
import System.Random
import System.Environment

pickRandomKanji :: StdGen -> IO ()
pickRandomKanji gen = do
    args <- getArgs
    let [fileName, _] = args
    contents <- readFile fileName
    let kanjis = lines contents
        (randNumber, newGen) = randomR (0, length kanjis - 1) gen :: (Int, StdGen)
        randKanji = kanjis !! randNumber
    putStrLn randKanji

shuffleListStep :: RandomGen g => (Map Int a, g) -> (Int, a) -> (Map Int a, g)
shuffleListStep (m, gen) (i, x) = ((insert j x . insert i (m ! j)) m, gen')
    where
        (j, gen') = randomR (0, i) gen
 
shuffleList :: RandomGen g => g -> [a] -> ([a], g)
shuffleList gen [] = ([], gen)
shuffleList gen l = 
    toElems $ foldl shuffleListStep (initial (head l) gen) (numerate (tail l))
    where
        toElems (x, y) = (elems x, y)
        numerate = zip [1..]
        initial x gen = (singleton 0 x, gen)

main = do
    args <- getArgs
    gen <- getStdGen
    let [fileName] = args
    contents <- readFile fileName
    let (randomKanjis, newGen) = shuffleList gen (lines contents)
    askKanjis randomKanjis

askKanjis :: [String] -> IO ()
askKanjis [] = return ()
askKanjis (kanji:remainingKanjis) = do
    let [k, _, d] = words kanji
    putStrLn $ "What's the kanji of: " ++ d
    answer <- getChar
--    putStrLn $ if answer == k then "Correct!" else "Wrong. It is " ++ k
    putStrLn $ "It is " ++ k ++ "\n"
    askKanjis remainingKanjis
