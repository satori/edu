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

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define outline-segments
  (list
    (make-segment
      (make-vect 0.0 0.0)
      (make-vect 0.0 0.99))
    (make-segment
      (make-vect 0.0 0.0)
      (make-vect 0.99 0.0))
    (make-segment
      (make-vect 0.0 0.99)
      (make-vect 0.99 0.99))
    (make-segment
      (make-vect 0.99 0.0)
      (make-vect 0.99 0.99))))

(define outline (segments->painter outline-segments))

(paint outline)

(define cross-segments
  (list
    (make-segment
      (make-vect 0.0 0.0)
      (make-vect 0.99 0.99))
    (make-segment
      (make-vect 0.0 0.99)
      (make-vect 0.99 0.0))))

(define cross (segments->painter cross-segments))

(paint cross)

(define diamond-segments
  (list
    (make-segment
      (make-vect 0.5 0.0)
      (make-vect 0.0 0.5))
    (make-segment
      (make-vect 0.0 0.5)
      (make-vect 0.5 0.999))
    (make-segment
      (make-vect 0.5 0.999)
      (make-vect 0.999 0.5))
    (make-segment
      (make-vect 0.999 0.5)
      (make-vect 0.5 0.0))))

(define diamond (segments->painter diamond-segments))

(paint diamond)

(define wave-segments
  (list
    (make-segment
      (make-vect 0.0 0.8)
      (make-vect 0.2 0.6))
    (make-segment
      (make-vect 0.2 0.6)
      (make-vect 0.3 0.65))
    (make-segment
      (make-vect 0.3 0.65)
      (make-vect 0.4 0.65))
    (make-segment
      (make-vect 0.4 0.65)
      (make-vect 0.35 0.85))
    (make-segment
      (make-vect 0.35 0.85)
      (make-vect 0.4 0.99))
    (make-segment
      (make-vect 0.0 0.6)
      (make-vect 0.2 0.4))
    (make-segment
      (make-vect 0.2 0.4)
      (make-vect 0.3 0.55))
    (make-segment
      (make-vect 0.3 0.55)
      (make-vect 0.34 0.5))
    (make-segment
      (make-vect 0.34 0.5)
      (make-vect 0.27 0.0))
    (make-segment
      (make-vect 0.6 0.99)
      (make-vect 0.65 0.85))
    (make-segment
      (make-vect 0.65 0.85)
      (make-vect 0.6 0.65))
    (make-segment
      (make-vect 0.6 0.65)
      (make-vect 0.75 0.65))
    (make-segment
      (make-vect 0.75 0.65)
      (make-vect 0.99 0.3))
    (make-segment
      (make-vect 0.73 0.0)
      (make-vect 0.6 0.5))
    (make-segment
      (make-vect 0.6 0.5)
      (make-vect 0.99 0.15))
    (make-segment
      (make-vect 0.4 0.0)
      (make-vect 0.5 0.25))
    (make-segment
      (make-vect 0.5 0.25)
      (make-vect 0.6 0.0))))

(define wave (segments->painter wave-segments))

(paint wave)
