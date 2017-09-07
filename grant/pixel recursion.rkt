;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |pixel recursion|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct pixel (x y color))

(define canvas (empty-scene 300 300))

(define (draw-pixel px scene)
  (place-image (square 1 "solid" (pixel-color px))
               (pixel-x px)
               (pixel-y px)
               scene))

(define blue (make-pixel 100 100 "blue"))
(define red (make-pixel 102 100 "red"))

(draw-pixel red (draw-pixel blue canvas))

(define (draw-horizontal-right x y length color scene)
  (cond
    [(zero? length) (draw-pixel (make-pixel x y color) scene)]
    [else (draw-pixel
           (make-pixel (+ x length) y color)
           (draw-horizontal-right x y (- length 1) color scene))]
    )
  )

(draw-horizontal-right 150 150 100 "black" canvas)
   