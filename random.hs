import Data.List
import System.Random

pickRandomKanji :: StdGen -> IO ()
pickRandomKanji gen = do
    contents <- getContents
    let kanjis = lines contents
        (randNumber, newGen) = randomR (0, length kanjis - 1) gen :: (Int, StdGen)
        randKanji = kanjis !! randNumber
    putStrLn randKanji

main = do
    gen <- getStdGen
    pickRandomKanji gen
