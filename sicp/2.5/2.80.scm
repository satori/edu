; Copyright (C) 2013-2014 by Maxim Bublis <b@codemonkey.ru>
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

(load "2.79.scm")

(define (=zero? x)
  (apply-generic '=zero? x))

(define (install-scheme-number-package)
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))

  'done)

(install-scheme-number-package)

(define (install-rational-package)
  (define (numer x)
    (car x))

  (put '=zero? '(rational)
       (lambda (x) (= (numer x) 0)))

  'done)

(install-rational-package)

(define (install-complex-package)
  (put '=zero? '(complex)
       (lambda (z) (and (= (real-part z) 0)
                        (= (imag-part z) 0))))

  'done)

(install-complex-package)

(=zero? 0)
(=zero? (make-rational 0 2))
(=zero? (make-complex-from-real-imag 0 0))
(=zero? (make-complex-from-real-imag 0 1))
(=zero? (make-complex-from-mag-ang 0 0))
