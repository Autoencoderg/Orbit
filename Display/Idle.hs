module Display.Idle where

import Graphics.UI.GLUT
import Data.IORef

import Game.State

idleUpdate :: IORef GLfloat -> IORef GameState -> IO ()
idleUpdate time gameState = do
  dT <- readIORef time
  
