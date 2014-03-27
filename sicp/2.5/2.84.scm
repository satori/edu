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
        (apply proc (map contents args))
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


(add 1 2)
(add 3 (make-rational 10 1))
(add (make-rational 3 4) (make-complex-from-real-imag 3 4))
(add (make-complex-from-real-imag 8 1) 2)
