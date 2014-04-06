; Copyright (C) 2014 by Maxim Bublis <b@codemonkey.ru>
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

(load "2.85.scm")

(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))

  (define (sub-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))

  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))

  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

  (define (tag z)
    (attach-tag 'complex z))

  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))

  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))

  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))

  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))

  (put 'equ? '(complex complex)
       (lambda (x y) (and (equ? (real-part x) (real-part y))
                          (equ? (imag-part x) (imag-part y)))))

  'done)

(install-complex-package)


(make-complex-from-real-imag (make-rational 3 2) 2)
(add (make-rational 6 2) (make-complex-from-real-imag (make-rational 4 2) 2))


(define (install-scheme-number-package)

  (define (tag x)
    (attach-tag 'scheme-number x))

  (put 'sine '(scheme-number)
       (lambda (x) (tag (sin x))))

  (put 'cosine '(scheme-number)
       (lambda (x) (tag (cos x))))

  'done)

(install-scheme-number-package)

(define (install-rational-package)
  (define (numer x)
    (car x))

  (define (denom x)
    (cdr x))

  (put 'sine '(rational)
       (lambda (x)
         (let ((rat
                 (inexact->exact
                   (sin (/ (numer x)
                           (denom x))))))
           (make-rational (numerator rat)
                          (denominator rat)))))

  (put 'cosine '(rational)
       (lambda (x)
         (let ((rat
                 (inexact->exact
                   (cos (/ (numer x)
                           (denom x))))))
           (make-rational (numerator rat)
                          (denominator rat)))))

  'done)

(install-rational-package)

(define (sine x)
  (apply-generic 'sine x))

(define (cosine x)
  (apply-generic 'cosine x))


(sine 3)
(sine (make-rational 1 3))
