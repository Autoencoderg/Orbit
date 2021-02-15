module Main where

import Graphics.UI.GLUT
import Data.IORef

import Display.Callback (display, reshape)
import   Input.Callback (keyboardMouse)

import Game.State

import Physics.Vector

main :: IO ()
main = do
  -- Initialization.
  (progName, args) <- getArgsAndInitialize
  let zero = (0 :: GLfloat)
  let testv = Spacecraft "Test" zero (Vec2 (zero, zero)) (Vec2 (zero, zero))
  gameState <- newIORef (GameState (0 :: GLfloat) [testv] testv)
  initialDisplayMode $= [DoubleBuffered]
  window           <- createWindow "Orbit"
  -- Callbacks.
  displayCallback       $=      display gameState
  reshapeCallback       $= Just reshape
  keyboardMouseCallback $= Just keyboardMouse
  -- Loop.
  mainLoop
