module Physics.Gravity where

import Graphics.UI.GLUT

import Physics.Vector

g :: GLfloat
g = 6.6743015e-11

force :: GLfloat -> GLfloat -> GLfloat -> GLfloat
force m1 m2 r =
  (-g*m1*m2)/(r**2)

forceVec :: GLfloat -> GLfloat -> Vec2 -> Vec2 -> Vec2
forceVec m1 m2 pFrom pTo =
  let
    p = pFrom - pTo
    m = magnitude p
  in
    (force m1 m2 m) .*. (unitVec p)
