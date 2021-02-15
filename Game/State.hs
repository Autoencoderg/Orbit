module Game.State (
    Vec2,
    Spacecraft (..),
    GameState (..)
  ) where

import Graphics.UI.GLUT

import Physics.Vector

data Spacecraft = Spacecraft {
    name        :: String,
    mass        :: GLfloat,
    position    :: Vec2,
    orientation :: Vec2,
    velocity    :: Vec2
  }

data GameState = GameState {
    time    :: GLfloat,
    craft   :: [Spacecraft],
    current :: Spacecraft
  }
