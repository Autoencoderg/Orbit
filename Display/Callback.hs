module Display.Callback (
  display,
  reshape
  ) where

import Graphics.UI.GLUT

import Game.State

reshape :: ReshapeCallback
reshape size = viewport $= (Position 0 0, size)

display :: IORef GameState -> DisplayCallback
display gameState = do
  clear [ColorBuffer]

  swapBuffers

idle :: IORef GameState -> IdleCallback
idle gameState = do
  postRedisplay Nothing
