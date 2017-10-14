;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname guess) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define lower 1)
(define upper 100)

(define (guess upper lower)
  (quotient (+ upper lower) 2))

(define (game lower upper target)
  (cond
    [(> target upper) "cheater!"]
    [(< target lower) "cheater!"]
    [(= (guess upper lower) target) target]
    [(> (guess upper lower) target) (game lower (guess upper lower) target)]
    [(< (guess upper lower) target) (game (guess upper lower) upper target)]
    ))
