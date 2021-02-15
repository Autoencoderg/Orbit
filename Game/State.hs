module Game.State (
    Vec2,
    Spacecraft (..),
    GameState (..)
  ) where

import Graphics.UI.GLUT

newtype Vec2 = (GLfloat, GLfloat)

data Spacecraft = Spacecraft {
    name        :: String,
    mass        :: GLfloat,
    position    :: Vec2,
    orientation :: Vec2,
  }

data GameState = GameState {
    time    :: GLfloat,
    craft   :: [Spacecraft],
    current :: Spacecraft
  }
