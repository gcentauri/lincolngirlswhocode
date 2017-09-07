
#lang racket
(require 2htdp/image)

(define (block color)
  (square 50 'solid color))

(define (ball color)
  (circle 25 'solid color))

(define (tri color)
  (triangle 50 'solid color))

(define rainbow (list 'red 'orange 'yellow 'green 'blue 'indigo 'violet))

(define (chain-of-shapes shape list-of-colors)
  (cond
    [(empty? list-of-colors) empty-image]
    [else (beside (shape (first list-of-colors))
                  (chain-of-shapes shape (rest list-of-colors)))]))

(define (bar color)
  (rectangle 100 50 'solid color))

(define double-rainbow (append rainbow (reverse rainbow)))