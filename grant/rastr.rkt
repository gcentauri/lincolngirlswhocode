#lang racket
(require 2htdp/image 2htdp/universe)

(define-struct game [canvas ship])

(define-struct ship [location velocity])

(define-struct posn [x y])

(define-struct vel [deltax deltay])

(define (add-velocity posn velocity)
  (make-posn (+ (posn-x posn) (vel-deltax velocity))
             (+ (posn-y posn) (vel-deltay velocity))))

(define player-ship (make-ship (make-posn 250 400) (make-vel 0 0)))

(define (ship-x s)
  (posn-x (ship-location s)))

(define (ship-y s)
  (posn-y (ship-location s)))

(define (draw-ship s)
  (triangle 20 'outline 'white))

(define (accelerate-ship s)
  (make-ship (ship-location s)
             (make-vel (vel-deltax (ship-velocity s))
                       (- (vel-deltay (ship-velocity s)) 0.3))))

(define (move-ship s)
  (make-ship (add-velocity (ship-location s) (ship-velocity s))
             (ship-velocity s)))

(define (drive-ship s)
  (move-ship (accelerate-ship s)))

(define background (overlay (square 500 'solid 'black)
                            (empty-scene 500 500)))


(define rastr (make-game background player-ship))

(define (tick-rastr g)
  (make-game background (drive-ship (game-ship g))))

(define (draw-rastr g)
  (place-image (draw-ship (game-ship g))
               (ship-x (game-ship g))
               (ship-y (game-ship g))
               (game-canvas g)))

(big-bang rastr
  [to-draw draw-rastr]
  [on-tick tick-rastr])

