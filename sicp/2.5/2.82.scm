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

(load "2.81.scm")

(define (apply-generic op . args)
  (define (find-coercion-target types)
    (define (can-coerce-into? target-type)
      (fold-left (lambda (x y) (and x y))
                 #t
                 (map (lambda (type)
                        (if
                          (or
                            (equal? type target-type)
                            (get-coercion type target-type))
                          target-type
                          #f))
                      types)))

    (fold-left (lambda (x y) (or x y))
               #f
               (map can-coerce-into? types)))

  (define (coerce-args target-type)
    (map
      (lambda (arg)
        (let ((type (type-tag arg)))
          (if (equal? type target-type)
            arg
            ((get-coercion type target-type) arg))))
      args))

  (define (no-method type-tags)
    (error "No method for these types"
           (list op type-tags)))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (let ((target-type (find-coercion-target type-tags)))
          (if target-type
            (let ((coerced-args (coerce-args target-type)))
              (fold-left
                (lambda (x y)
                  (apply
                    apply-generic
                    (list op x y)))
                (car coerced-args)
                (cdr coerced-args)))
            (no-method type-tags)))))))


(apply-generic 'add 1 (make-complex-from-real-imag 2 2) 3)
