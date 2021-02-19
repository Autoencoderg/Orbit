module Display.Callback (
  display,
  reshape,
  idle
  ) where

import qualified Data.Map as M

import Graphics.UI.GLUT
import Data.IORef
import System.CPUTime (getCPUTime)

import Game.State
import Data.Ships

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

display :: IORef GLfloat -> IORef GameState -> DisplayCallback
display time gameState = do
  startTime <- getCPUTime
  clear [ColorBuffer]
  loadIdentity
  lineWidth $= 3
  preservingMatrix $ do
    gameState' <- readIORef gameState
    craft' <- readIORef (craft gameState')
    look' <- readIORef (current gameState')
    current' <- readIORef (craft' M.! look')
    o <- readIORef (orientation current')
    rotate (fromIntegral o :: GLfloat) $ Vector3 0 0 1
    shipOne
  endTime <- getCPUTime
  time $= (fromIntegral (endTime - startTime) / 1000000000000 :: GLfloat)
  swapBuffers

idleUpdate :: IORef GLfloat -> IORef GameState -> IO ()
idleUpdate time gameState = return () 

idle :: IORef GLfloat -> IORef GameState -> IdleCallback
idle time gameState = do
  idleUpdate time gameState
  postRedisplay Nothing
