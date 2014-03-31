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

(load "2.87.scm")

(define (neg x)
  (apply-generic 'neg x))


(define (install-scheme-number-package)

  (put 'neg '(scheme-number)
       (lambda (x) (- x)))

  'done)

(install-scheme-number-package)

(define (install-polynomial-package)

  (define (make-poly variable term-list)
    (cons variable term-list))

  (define (variable p)
    (car p))

  (define (term-list p)
    (cdr p))

  (define (variable? x)
    (symbol? x))

  (define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))

  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

  (define (the-empty-termlist) '())

  (define (first-term term-list)
    (car term-list))

  (define (rest-terms term-list)
    (cdr term-list))

  (define (empty-termlist? term-list)
    (null? term-list))

  (define (make-term order coeff)
    (list order coeff))

  (define (order term)
    (car term))

  (define (coeff term)
    (cadr term))

  (define (negate-terms terms)
    (if (empty-termlist? terms)
      (the-empty-termlist)
      (let ((t1 (first-term terms)))
        (adjoin-term
          (make-term (order t1) (neg (coeff t1)))
          (negate-terms (rest-terms terms))))))

  (define (negate-poly p)
    (make-poly
      (variable p)
      (negate-terms (term-list p))))


  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin-term
                       t1 (add-terms (rest-terms L1) L2)))
                    ((< (order t1) (order t2))
                     (adjoin-term
                       t2 (add-terms L1 (rest-terms L2))))
                    (else
                      (adjoin-term
                        (make-term (order t1)
                                   (add (coeff t1) (coeff t2)))
                        (add-terms (rest-terms L1)
                                   (rest-terms L2)))))))))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))

  (define (sub-poly p1 p2)
    (add-poly p1 (negate-poly p2)))

  (define (tag p)
    (attach-tag 'polynomial p))

  (put 'neg '(polynomial)
       (lambda (p)
         (tag (negate-poly p))))

  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (sub-poly p1 p2))))

  'done)

(install-polynomial-package)

(sub (make-polynomial 'x '((2 5) (1 3) (0 7)))
     (make-polynomial 'x '((2 1) (1 1) (0 7))))
