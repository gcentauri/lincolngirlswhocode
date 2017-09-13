#lang racket
(require 2htdp/image 2htdp/universe)

(define-struct game [canvas ship])

(define-struct ship [location velocity angle])

(define-struct posn [x y])

(define-struct vel [deltax deltay])

(define (add-velocity posn velocity)
  (make-posn (+ (posn-x posn) (vel-deltax velocity))
             (+ (posn-y posn) (vel-deltay velocity))))

(define avatar (add-line (triangle 30 'outline 'white)
                         15 0 15 15 'red))

(define player-ship (make-ship (make-posn 250 250)
                               (make-vel 0 0)
                               0))

(define (ship-on-blank the-hero)
  (define the-hero avatar)
  (define w (image-width the-hero))
  (define h (image-height the-hero))
  (define d (max w h))
  (define dx (/ w 2))   ; centroid x offset
  (define dy (* 2/3 h)) ; centroid y offset
  (define blank  (circle d "solid" "black"))
  (place-image/align the-hero (- d dx) (- d dy) "left" "top" blank))

(define (ship-x s)
  (posn-x (ship-location s)))

(define (ship-y s)
  (posn-y (ship-location s)))

(define (draw-ship s)
  (rotate (ship-angle s) (ship-on-blank avatar)))

(define (degrees->radians d)
  (* d (/ pi 180)))

(define (accelerate-ship s)
  (define move-velocity
    (make-vel (* (sin (degrees->radians (ship-angle s))) -1)
              (* (cos (degrees->radians (ship-angle s))) -1)))
  (make-ship (ship-location s)
             (make-vel (+ (vel-deltax (ship-velocity s))
                          (vel-deltax move-velocity))
                       (+ (vel-deltay (ship-velocity s))
                          (vel-deltay move-velocity)))
             (ship-angle s)))

(define (turn-ship a s)
  (make-ship (ship-location s)
             (ship-velocity s)
             (+ (ship-angle s) a)))

(define (move-ship s)
  (make-ship (add-velocity (ship-location s) (ship-velocity s))
             (ship-velocity s)
             (ship-angle s)))

(define background (overlay (square 500 'solid 'black)
                            (empty-scene 500 500)))

(define (put-image i p s)
  (place-image i (posn-x p) (posn-y p) s))

(define rastr (make-game background player-ship))

(define (tick-rastr g)
  (make-game background (move-ship (game-ship g))))

(define (draw-rastr g)
  (let ([ship (game-ship g)])
    (put-image (draw-ship ship)
               (ship-location ship)
               (game-canvas g))))

(define (change g a-key)
  (cond
    [(key=? a-key "left") (make-game background (turn-ship 15 (game-ship g)))]
    [(key=? a-key "right") (make-game background (turn-ship -15 (game-ship g)))]
    [(key=? a-key "up") (make-game background (accelerate-ship (game-ship g)))]
    ))

(big-bang rastr
  [on-key change]
  [to-draw draw-rastr]
  [on-tick tick-rastr])
