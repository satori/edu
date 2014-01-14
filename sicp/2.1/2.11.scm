; Copyright (C) 2013 by Maxim Bublis <b@codemonkey.ru>
;
; Permission is hereby granted, free of charge, to any person obtaining
; a copy of this software and associated documentation files (the
; "Software"), to deal in the Software without restriction, including
; without limitation the rights to use, copy, modify, merge, publish,
; distribute, sublicense, and/or sell copies of the Software, and to
; permit persons to whom the Software is furnished to do so, subject to
; the following conditions:
;
; The above copyright notice and this permission notice shall be
; included in all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
; NONINFRINGMENT. IN NOT EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(define (mul-interval x y)
  (let ((low-x (lower-bound x))
        (up-x (upper-bound x))
        (low-y (lower-bound y))
        (up-y (upper-bound y)))
    (cond ((and (>= low-x 0)
                (>= up-x 0)
                (>= low-y 0)
                (>= up-y 0))
           (make-interval (* low-x low-y) (* up-x up-y)))
          ((and (>= low-x 0)
                (>= up-x 0)
                (< low-y 0)
                (>= up-y 0))
           (make-interval (* up-x low-y) (* up-x up-y)))
          ((and (>= low-x 0)
                (>= up-x 0)
                (< low-y 0)
                (< up-y 0))
           (make-interval (* up-x low-y) (* low-x up-y)))
          ((and (< low-x 0)
                (>= up-x 0)
                (>= low-y 0)
                (>= up-y 0))
           (make-interval (* low-x up-y) (* up-x up-y)))
          ((and (< low-x 0)
                (>= up-x 0)
                (< low-y 0)
                (>= up-y 0))
           (make-interval (min (* low-x up-y) (* up-x low-y))
                          (max (* low-x low-y) (* up-x up-y))))
          ((and (< low-x 0)
                (>= up-x 0)
                (< low-y 0)
                (< up-y 0))
           (make-interval (* up-x low-y) (* low-x low-y)))
          ((and (< low-x 0)
                (< up-x 0)
                (>= low-y 0)
                (>= up-y 0))
           (make-interval (* low-x up-y) (* up-x low-y)))
          ((and (< low-x 0)
                (< up-x 0)
                (< low-y 0)
                (>= up-y 0))
           (make-interval (* low-x up-y) (* low-x low-y)))
          ((and (< low-x 0)
                (< up-x 0)
                (< low-y 0)
                (< up-y 0))
           (make-interval (* up-x up-y) (* low-x low-y))))))

(define interval-a (make-interval 2 4))
(define interval-b (make-interval -2 4))
(define interval-c (make-interval -4 -2))

(mul-interval interval-a interval-a)
(mul-interval interval-a interval-b)
(mul-interval interval-a interval-c)
(mul-interval interval-b interval-a)
(mul-interval interval-b interval-b)
(mul-interval interval-b interval-c)
(mul-interval interval-c interval-a)
(mul-interval interval-c interval-b)
(mul-interval interval-c interval-c)
