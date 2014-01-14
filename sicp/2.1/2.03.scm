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

(define (square x)
  (* x x))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment start end)
  (cons start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (length-segment s)
  (sqrt (+ (square (- (x-point (start-segment s))
                      (x-point (end-segment s))))
           (square (- (y-point (start-segment s))
                      (y-point (end-segment s)))))))

(define (make-rectangle north-east-corner south-west-corner)
  (cons north-east-corner south-west-corner))

(define (north-east-rectangle r)
  (car r))

(define (south-west-rectangle r)
  (cdr r))

(define (width-rectangle r)
  (abs (- (x-point (north-east-rectangle r))
          (x-point (south-west-rectangle r)))))

(define (height-rectangle r)
  (abs (- (y-point (north-east-rectangle r))
          (y-point (south-west-rectangle r)))))

(define (perimeter-rectangle r)
  (* 2
     (+ (width-rectangle r)
        (height-rectangle r))))

(define (area-rectangle r)
  (* (width-rectangle r)
     (height-rectangle r)))

(define rect (make-rectangle (make-point 10 10) (make-point 20 20)))

(perimeter-rectangle rect)
(area-rectangle rect)


(define (make-rectangle x-segment y-segment)
  (cons x-segment y-segment))

(define (x-segment r)
  (car r))

(define (y-segment r)
  (cdr r))

(define (width-rectangle r)
  (length-segment (x-segment r)))

(define (height-rectangle r)
  (length-segment (y-segment r)))

(define rect (make-rectangle (make-segment (make-point 10 10) (make-point 10 20)
                                           (make-segment (make-point 20 10) (make-point 20 20))))

(perimeter-rectangle rect)
(area-rectangle rect)
