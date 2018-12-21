{-# LANGUAGE OverloadedStrings #-}
module Main where

import KanjiApi
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Servant.API()

server :: Server KanjiApi
server = return "wow"
    :<|> return [Kanji "1" "2" "3"]

app :: Application
app = serve kanjiApi server

main :: IO ()
main = do
    let port = 9000
    kanji <- findAllKanji
    case kanji of
        Just a -> putStrLn (character a)
        Nothing -> putStrLn "Nothing here"
    putStrLn $ "Listening to port " ++ show port
    run port app
