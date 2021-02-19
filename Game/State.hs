module Game.State (
    Vec2,
    Spacecraft (..),
    GameState (..),
    makeCraft,
    makeState,
    getCurrentCraftRef
  ) where

import qualified Data.Map as M
import Data.IORef

import Graphics.UI.GLUT

import Physics.Vector

data Spacecraft = Spacecraft {
    name        :: IORef String,
    mass        :: IORef GLfloat,
    position    :: IORef Vec2,
    orientation :: IORef GLint,
    velocity    :: IORef Vec2,
    thrust      :: IORef GLint,
  }

data GameState = GameState {
    time    :: IORef GLfloat,
    craft   :: IORef (M.Map GLint (IORef Spacecraft)),
    current :: IORef GLint,
    zoom    :: IORef GLfloat,
  }

makeCraft :: String -> GLfloat -> Vec2 -> GLint -> Vec2 -> IO (IORef Spacecraft)
makeCraft n m p o v = do
  n' <- newIORef n
  m' <- newIORef m
  p' <- newIORef p
  o' <- newIORef o
  v' <- newIORef v
  craft <- newIORef $ Spacecraft n' m' p' o' v'
  return craft

makeState :: GLfloat -> M.Map GLint (IORef Spacecraft) -> GLint -> IO (IORef GameState)
makeState t cs c = do
  t'  <- newIORef t
  cs' <- newIORef cs
  c'  <- newIORef c
  gameState <- newIORef $ GameState t' cs' c'
  return gameState

getCurrentCraftRef :: IORef GameState -> IO (IORef Spacecraft)
getCurrentCraftRef gameState = do
  gameState' <- readIORef gameState
  craft'     <- readIORef (craft   gameState')
  lookup'    <- readIORef (current gameState')
  return $ craft' M.! lookup'

