;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname polygon-rastr) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;;define a point in space at (50, 40) i.e. x = 50, y = 40
;;the origin is in the top left, and y increasing is downward
(define ship-center (make-posn 150 150))

;; define a set of relationships
(define (nose center)
  (make-posn (posn-x center) (- (posn-y center) 40)))
(define (wing-left center)
  (make-posn (- (posn-x center) 20) (+ (posn-y center) 20)))
(define (wing-right center)
  (make-posn (+ (posn-x center) 20) (+ (posn-y center) 20)))

(define (degrees->radians θ)
  (* θ (/ pi 180)))

;; define an angle in radians (or whatever we want to measure angles in)
(define ship-angle (degrees->radians 45))

(define (rotate-posn posn center θ)
  (let* ([cx (posn-x center)]
         [cy (posn-y center)]
         [x (- (posn-x posn) cx)]
         [y (- (posn-y posn) cy)])
    (make-posn
     (+ cx (- (* x (cos θ))
              (* y (sin θ))))
     (+ cy (+ (* x (sin θ))
              (* y (cos θ)))))))
        
(define (draw-ship θ)
  (let ([rads (degrees->radians θ)])
     (polygon (list (rotate-posn (nose ship-center) ship-center rads)
                   (rotate-posn (wing-right ship-center) ship-center rads)
                   (rotate-posn (wing-left ship-center) ship-center rads))
             'solid
             'teal)))

(place-image (overlay (square 2 'solid 'yellow)
                      (add-line
                       (add-line (rectangle 40 60 'outline 'yellow)
                                 20 0 20 60 'pink)
                       0 30 40 30 'pink)
                      (draw-ship ship-angle)
                      (square 300 'solid 'black))
             150 150
             (empty-scene 300 300))
