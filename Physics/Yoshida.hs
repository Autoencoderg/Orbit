module Physics.Yoshida (
    yoshidaStep
  ) where

import Graphics.UI.GLUT

import Physics.Vector

cbrt2, w0, w1, c14, c23 :: GLfloat
cbrt2 = 2 ** (1/3)
w0    = -(cbrt2/(2-cbrt2))
w1    = 1/(2-cbrt2)
c14   = w1/2
c23   = (w0+w1)/2

yoshidaStep :: ((Vec2, Vec2) -> Vec2) -> GLfloat ->
               (Vec2, Vec2) -> (Vec2, Vec2)
yoshidaStep a dT (x, v) =
  let
    x1 = x  + ((c14 * dT) .*. v           )
    v1 = v  + ((w1  * dT) .*. (a (x1, v )))
    x2 = x1 + ((c23 * dT) .*. v1          )
    v2 = v1 + ((w0  * dT) .*. (a (x2, v1)))
    x3 = x2 + ((c23 * dT) .*. v2          )
    v3 = v2 + ((w1  * dT) .*. (a (x3, v2)))
  in
    (x3 + ((c14 * dT) .*. v3), v3)
