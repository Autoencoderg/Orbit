module Main where

import Graphics.UI.GLUT

import Display.Callback (display, reshape)
import   Input.Callback (keyboardMouse)

main :: IO ()
main = do
  -- Initialization.
  (progName, args) <- getArgsAndInitialize
  window           <- createWindow "Orbit"
  -- Callbacks.
  displayCallback       $=      display
  reshapeCallback       $= Just reshape
  keyboardMouseCallback $= Just keyboardMouse
  -- Loop.
  mainLoop
