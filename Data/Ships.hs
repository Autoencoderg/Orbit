module Data.Ships where

import Graphics.UI.GLUT

vertex2f :: (GLfloat, GLfloat) -> IO ()
vertex2f (x, y) = vertex $ Vertex2 x y

shipOne :: IO ()
shipOne = renderPrimitive LineLoop $ mapM_ vertex2f [
  (  0,          1      ), (  0.18568,    0.6647 ), (  0.25273,    0.345  ),
  (  0.19445,  (-0.0506)), (  0.3198,   (-0.2766)), (  0.31256,  (-0.5917)),
  (  0.16299,  (-0.4168)), (  0,        (-0.3479)), ((-0.16299), (-0.4168)),
  ((-0.31256), (-0.5917)), ((-0.3198 ), (-0.2766)), ((-0.19445), (-0.0506)),
  ((-0.25273),   0.345  ), ((-0.18568),   0.6647 )
  ]
