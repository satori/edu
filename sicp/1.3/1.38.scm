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

(define (cont-frac n d k)
  (define (fraction i)
    (/ (n i) (+ (d i)
                (cond ((> i k) 0.0)
                      (else (fraction (+ i 1)))))))
  (fraction 1))

(define (euler-e n)
  (+ 2
     (cont-frac (lambda (i) 1.0)
                (lambda (i)
                  (cond ((= 0 (remainder (+ i 1) 3))
                         (* 2.0 (/ (+ i 1) 3)))
                        (else 1.0)))
                n)))

(euler-e 5)
(euler-e 10)
(euler-e 20)
