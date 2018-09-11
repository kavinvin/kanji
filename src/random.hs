import Data.List hiding (insert)
import Data.Map hiding (foldl)
import System.Random
import System.Environment
import Shuffle

main = do
    args <- getArgs
    gen <- getStdGen
    let [fileName] = args
    contents <- readFile fileName
    let (randomKanjis, newGen) = shuffle gen (lines contents)
    askKanjis randomKanjis

askKanjis :: [String] -> IO ()
askKanjis [] = return ()
askKanjis (kanji:remainingKanjis) = do
    let [k, _, d] = words kanji
    putStrLn $ "What's the kanji of: " ++ d
    answer <- getChar
    putStrLn $ "It is " ++ k ++ "\n"
    askKanjis remainingKanjis
