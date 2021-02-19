module Input.Callback where

import System.Exit (exitWith, ExitCode(ExitSuccess))
import qualified Data.Map as M

import Graphics.UI.GLUT
import Data.IORef

import Game.State

getAngle :: GLfloat -> GLfloat -> GLint
getAngle x y =
  floor $ ((atan2 x y)+pi)*(180/pi)

keyboardMouse :: IORef GameState -> KeyboardMouseCallback
keyboardMouse gameState (Char c) Down _ _ = case c of
  --'a' -> updateCur orientation ((`mod` (360 :: GLint)) . (+ 5))
  --'s' -> updateCur orientation ((`mod` (360 :: GLint)) . (+ (-5)))
  '\27' -> exitWith ExitSuccess
  _     -> updateOri
  where
    updateGlobal  value change = do
      gameState' <- readIORef gameState
      value gameState' $~! change
      postRedisplay Nothing
    updateCurrent value change = do
      currentRef <- getCurrentCraftRef gameState
      current'   <- readIORef currentRef
      value current' $~! change
      postRedisplay Nothing
keyboardMouse _ _ _ _ _ = return ()

passiveMotion :: StateVar Size -> IORef GameState -> MotionCallback
passiveMotion size gameState (Position x y) = do
    (Size sx sy) <- get size
    let x' = x - (sx `div` 2)
        y' = y - (sy `div` 2)
    currentRef <- getCurrentCraftRef gameState
    current'   <- readIORef currentRef
    orientation current' $= getAngle (fromIntegral x') (fromIntegral y')
    postRedisplay Nothing

mouseWheel :: IORef GameState -> MouseWheelCallback
mouseWheel gameState _ direction (Position x y) = do
  gameState' <- readIORef gameState
  zoom gameState' $~! 
