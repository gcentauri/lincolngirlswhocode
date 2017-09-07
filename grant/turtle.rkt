#lang racket

(require graphics/turtles)
(turtles #true)

(define (square x)
  (draw x)
  (turn 90)
  (draw x)
  (turn 90)
  (draw x)
  (turn 90)
  (draw x)
  (turn 90)
  )

(define (draw-square-side length)
  (draw length)
  (turn 90))

(define (repeat n func)
  (cond
    [(zero? n) (void)]
    [else (eval func)
          (repeat (- n 1) func)]))

(define (square2 size)
  (repeat 4 '(draw-square-side size)))

(square2 10)