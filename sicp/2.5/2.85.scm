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

(load "2.83.scm")


(define (complex->rational n)
  (let ((rat (inexact->exact (real-part n))))
    (make-rational (numerator rat)
                   (denominator rat))))

(put 'project '(complex)
     complex->rational)

(define (rational->scheme-number n)
  (define (numer x)
    (car x))

  (define (denom x)
    (cdr x))

  (floor (/ (numer n)
            (denom n))))

(put 'project '(rational)
     rational->scheme-number)

(define (drop arg)
  (let ((type (type-tag arg)))
    (let ((project (get 'project (list type))))
      (if project
        (let ((projected (project (contents arg))))
          (let ((raise (get 'raise (list (type-tag projected)))))
            (if (equal? arg (raise (contents projected)))
              (drop projected)
              arg)))
        arg))))

(define (apply-generic op . args)
  (define (no-method type-tags)
    (error "No method for these types"
           (list op type-tags)))

  (define (raise-into source target-type)
    (let ((source-type (type-tag source)))
      (cond ((equal? source-type target-type)
             source)
            ((get 'raise (list source-type))
             (raise-into (apply-generic 'raise source) target-type))
            (else #f))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (drop (apply proc (map contents args)))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (cond
              ((raise-into a1 type2)
               (apply-generic op (raise-into a1 type2) a2))
              ((raise-into a2 type1)
               (apply-generic op a1 (raise-into a2 type1)))
              (else
                (no-method type-tags))))
          (no-method type-tags))))))

(drop (make-complex-from-real-imag 1.5 0))
(drop (make-complex-from-real-imag 1. 0))
(drop (make-complex-from-real-imag 2 3))

(add (make-complex-from-real-imag 2. 3) (make-complex-from-real-imag 4. -3))
(add (make-complex-from-real-imag 2. 3) (make-complex-from-real-imag 4. -1))
