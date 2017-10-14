;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname drawing) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require "trees.rkt")

(overlay (circle 10 "solid" "white")
         (circle 20 "solid" "silver")
         (circle 30 "solid" "light blue")
         (circle 40 "solid" "aqua")
         (circle 50 "solid" "teal")
         (circle 60 "solid" "lightgreen")
         (circle 70 "solid" "green")
         (circle 80 "solid" "yellow")
         (circle 90 "solid" "orange")
         (circle 100 "solid" "red")
         (circle 110 "solid" "purple"))

(define (block color)
  (square 50 "solid" color))

(beside (block "orange")
        (block "blue"))

;;(define (tree size)
 ;; (above (triangle (* 10 size) "solid" "darkgreen")
   ;;      (rectangle (* 2 size) (* 5 size) "solid" "brown")))

(overlay/align "left" "bottom"
               (beside/align "bottom" (tree 4) (tree 2) (tree 6))
               (rectangle 150 100 "solid" "skyblue"))

(define (create-tree-scene size)
    (overlay (tree (modulo size 23))
             (rectangle 350 350 "solid" "skyblue")))

;; ticks a clock 28 times per second and sends the number
;; of the clock tick to as an argument to the function given
(animate create-tree-scene)