{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module KanjiApi where

import Servant.API
import Data.Text
import Data.Proxy
import Data.Aeson.Types
import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy as B

data Kanji = Kanji
    { character :: String
    , meaning :: String
    , reading :: String
    } deriving (Eq, Show, Generic)

instance ToJSON Kanji
instance FromJSON Kanji

type KanjiApi = Get '[PlainText] Text
           :<|> "kanji" :> Get '[JSON] [Kanji]

findAllKanji :: IO (Maybe Kanji) 
findAllKanji = do
    fmap decode (B.readFile "resources/kanji.json")

kanjiApi :: Proxy KanjiApi
kanjiApi = Proxy
