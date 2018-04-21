{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
module Main where

import Data.Text    (Text)
import Turtle
import Data.Map     (Map)
import Data.Monoid  ((<>))
import Data.Yaml
import GHC.Generics

data DeploymentLocation = DeploymentLocation
  { cluster :: Text
  , path    :: Text
  } deriving (Generic, Show, Eq, Ord, FromJSON, ToJSON)

formatDeploymentLocation :: DeploymentLocation -> Text
formatDeploymentLocation (DeploymentLocation cluster' path') =
  cluster' <> ":" <> path'

data Projects = Projects { projects :: Map Text DeploymentLocation }
  deriving (Generic, Show, Eq, Ord, FromJSON, ToJSON)

main :: IO ()
main = do
  sh $ shell "sbt rpm:packageBin" empty
  putStrLn "Build package"
