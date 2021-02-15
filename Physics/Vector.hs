module Physics.Vector where

import Graphics.UI.GLUT

newtype Vec2 = Vec2 (GLfloat, GLfloat) deriving (Show, Read)

apply :: (GLfloat -> GLfloat) -> Vec2 -> Vec2
apply f (Vec2 (x, y)) = Vec2 (f x, f y)

apply2 :: (GLfloat -> GLfloat -> GLfloat) -> Vec2 -> Vec2 -> Vec2
apply2 f (Vec2 (x1, y1)) (Vec2 (x2, y2)) = Vec2 (f x1 x2, f y1 y2)

magnitude :: Vec2 -> GLfloat
magnitude v =
  let
    (Vec2 (a, b)) = v ** (Vec2 (2, 2))
  in
    sqrt (a + b)

unitVec :: Vec2 -> Vec2
unitVec v = ((recip . magnitude) v) .*. v

(.*.) :: GLfloat -> Vec2 -> Vec2
(.*.) s v = apply (*s) v

(...) :: Vec2 -> Vec2 -> GLfloat
(...) v1 v2 =
  let
    (Vec2 (a, b)) = v1 * v2
  in
    a + b

instance Num Vec2 where
  (+)    a b      = apply2 (*) a b
  (-)    a b      = apply2 (-) a b
  (*)    a b      = apply2 (*) a b
  negate a        = apply negate a
  abs    a        = apply abs a
  signum a        = apply signum a
  fromInteger int = Vec2 (fromInteger int, fromInteger int)

instance Fractional Vec2 where
  a / b          = apply2 (/) a b
  recip a        = apply recip a
  fromRational r = Vec2 (fromRational r, fromRational r)

instance Floating Vec2 where
  pi          = Vec2 (pi, pi)
  exp     a   = apply  exp     a
  log     a   = apply  log     a
  sqrt    a   = apply  sqrt    a
  (**)    a b = apply2 (**)    a b
  logBase a b = apply2 logBase a b
  sin     a   = apply  sin     a
  cos     a   = apply  cos     a
  tan     a   = apply  tan     a
  asin    a   = apply  asin    a
  acos    a   = apply  acos    a
  atan    a   = apply  atan    a
  sinh    a   = apply  sinh    a
  cosh    a   = apply  cosh    a
  tanh    a   = apply  tanh    a
  asinh   a   = apply  asinh   a
  acosh   a   = apply  acosh   a
  atanh   a   = apply  atanh   a

instance Eq Vec2 where
  (Vec2 (x1, y1)) == (Vec2 (x2, y2)) = (x1 == x2) && (y1 == y2)
  a               /= b               = not (a == b)
