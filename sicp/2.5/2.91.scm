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

(load "2.90.scm")


(define (install-term-package)

  (define (make-term order coeff)
    (list order coeff))

  (define (order-term term)
    (car term))

  (define (coeff-term term)
    (cadr term))

  (define (div-term t1 t2)
    (make-term (- (order-term t1) (order-term t2))
               (div (coeff-term t1) (coeff-term t2))))

  (define (tag x)
    (attach-tag 'term x))

  (put 'div '(term term)
       (lambda (t1 t2)
         (tag (div-term t1 t2))))

  'done)

(install-term-package)


(define (install-terms-package)
  (define (add-terms L1 L2)
    (cond ((=zero? L1) L2)
          ((=zero? L2) L1)
          (else
            (let ((t1 (first L1))
                  (t2 (first L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin
                       t1 (add-terms (rest L1) L2)))
                    ((< (order t1) (order t2))
                     (adjoin
                       t2 (add-terms L1 (rest L2))))
                    (else
                      (adjoin
                        (add t1 t2)
                        (add-terms (rest L1)
                                   (rest L2)))))))))

  (define (mul-terms L1 L2)
    (if (=zero? L1)
      L1
      (add-terms (mul-term-by-all-terms (first L1) L2)
                 (mul-terms (rest L1) L2))))

  (define (mul-term-by-all-terms t1 term-list)
    (if (=zero? term-list)
      term-list
      (let ((t2 (first term-list)))
        (adjoin
          (mul t1 t2)
          (mul-term-by-all-terms t1 (rest term-list))))))

  (define (negate-terms term-list)
    (if (=zero? term-list)
      term-list
      (let ((t1 (first term-list)))
        (adjoin
          (neg t1)
          (negate-terms (rest term-list))))))

  (define (div-terms L1 L2)
    (let ((the-empty-list
            (lambda () ((get 'make (type-tag L1)) '()))))
      (if (=zero? L1)
        (list (the-empty-list) (the-empty-list))
        (let ((t1 (first L1))
              (t2 (first L2)))
          (if (> (order t2) (order t1))
            (list (the-empty-list) L1)
            (let ((new-term (div t1 t2)))
              (let ((rest-of-result
                      (div-terms (add-terms
                                   L1
                                   (negate-terms
                                     (mul-terms L2 (adjoin new-term (the-empty-list)))))
                                 L2)))
                (list
                  (adjoin new-term (car rest-of-result))
                  (cadr rest-of-result)))))))))

  (define (tag x)
    (attach-tag 'terms x))

  (put 'div '(terms terms)
       (lambda (L1 L2)
         (let ((div-result (div-terms L1 L2)))
           (list
             (tag (car div-result))
             (tag (cadr div-result))))))

  'done)

(install-terms-package)

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

  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (let ((div-result (div (term-list p1) (term-list p2))))
        (list
          (make-poly (variable p1) (car div-result))
          (make-poly (variable p1) (cadr div-result))))
      (error "Polys not in same var -- DIV-POLY"
             (list p1 p2))))

  (define (tag p)
    (attach-tag 'polynomial p))

  (put 'div '(polynomial polynomial)
       (lambda (p1 p2)
         (let ((div-result (div-poly p1 p2)))
           (list
             (tag (car div-result))
             (tag (cadr div-result))))))

  'done)

(install-polynomial-package)


(div (make-polynomial 'x (make-term-list-from-terms (list (make-term 5 1) (make-term 0 -1))))
     (make-polynomial 'x (make-term-list-from-terms (list (make-term 2 1) (make-term 0 -1)))))

(div (make-polynomial 'x (make-term-list-from-coeffs '(1 0 0 0 0 -1)))
     (make-polynomial 'x (make-term-list-from-coeffs '(1 0 -1))))
