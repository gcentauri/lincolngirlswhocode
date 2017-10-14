#lang racket
(require 2htdp/image)

(provide tree)

(define (tree size)
  (above (triangle (* 10 size) "solid" "darkgreen")
         (rectangle (* 2 size) (* 5 size) "solid" "brown")))

(provide print-cake)
 
; draws a cake with n candles
(define (print-cake n)
  (show "   ~a   " n #\.)
  (show " .-~a-. " n #\|)
  (show " | ~a | " n #\space)
  (show "---~a---" n #\-))
 
(define (show fmt n ch)
  (printf fmt (make-string n ch))
  (newline))