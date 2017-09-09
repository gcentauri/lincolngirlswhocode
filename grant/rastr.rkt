#lang racket
(require 2htdp/image 2htdp/universe)

(define-struct game [canvas ship])

(define-struct ship [location velocity])

(define-struct posn [x y])

(define-struct vel [deltax deltay])

(define player-ship (make-ship (make-posn 250 400) (make-vel 0 0)))

(define (draw-ship s)
  (triangle 20 'outline 'white))

(define (accelerate-ship s)
  (make-ship (ship-location s)
             (make-vel (vel-deltax (ship-velocity s))
                       (sub1 (vel-deltay (ship-velocity s))))))

(define (move-ship s)
  (make-ship (make-posn (+ (posn-x (ship-location s))
                           (vel-deltax (ship-velocity s)))
                        (+ (posn-y (ship-location s))
                           (vel-deltay (ship-velocity s))))
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
               (posn-x (ship-location (game-ship g)))
               (posn-y (ship-location (game-ship g)))
               (game-canvas g)))

(big-bang rastr
  [to-draw draw-rastr]
  [on-tick tick-rastr])

