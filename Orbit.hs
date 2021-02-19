module Main where

import qualified Data.Map as M

import Graphics.UI.GLUT
import Data.IORef
import System.CPUTime (getCPUTime)

import Display.Callback (display, reshape, idle)
import   Input.Callback (keyboardMouse, passiveMotion)

import Game.State

import Physics.Vector

main :: IO ()
main = do
  -- Initialization.
  (progName, args) <- getArgsAndInitialize
  let zero = (0 :: GLfloat)
  spaceCraft <- makeCraft "Test" zero (Vec2 (zero, zero)) (0 :: GLint) (Vec2 (zero, zero))
  gameState <- makeState zero (M.singleton (1 :: GLint) spaceCraft) (1 :: GLint)
  curTime <- getCPUTime
  time <- newIORef $ (fromIntegral curTime / 1000000000000 :: GLfloat)
  initialDisplayMode $= [DoubleBuffered]
  window           <- createWindow "Orbit"
  -- Callbacks.
  displayCallback       $=      display time gameState
  reshapeCallback       $= Just reshape
  keyboardMouseCallback $= Just (keyboardMouse gameState)
  passiveMotionCallback $= Just (passiveMotion windowSize gameState)
  idleCallback          $= Just (idle time gameState)
  -- Loop.
  mainLoop
