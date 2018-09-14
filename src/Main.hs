{-# LANGUAGE OverloadedStrings #-}
module Main where

import           HelloApi
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Servant.API()

server :: Server HelloAPI
server = hello :<|> user
    where
        hello = return "Hello world"
        user n a = return $ User n a

app :: Application
app = serve helloApi server

main :: IO ()
main = do
    let port = 9000
    putStrLn $ "Listening to port " ++ show port
    run port app
