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

(load "2.88.scm")

(define (install-term-package)

  (define (make-term order coeff)
    (list order coeff))

  (define (order-term term)
    (car term))

  (define (coeff-term term)
    (cadr term))

  (define (add-term t1 t2)
    (if (equal? (order-term t1) (order-term t2))
      (make-term (order-term t1)
                 (add (coeff-term t1) (coeff-term t2)))
      (error "Terms not in same order -- ADD-TERM"
             (list t1 t2))))

  (define (mul-term t1 t2)
    (make-term (+ (order-term t1) (order-term t2))
               (mul (coeff-term t1) (coeff-term t2))))

  (define (negate-term term)
    (make-term (order-term term)
               (neg (coeff-term term))))

  (define (zero-term? term)
    (=zero? (coeff-term term)))

  (define (tag x)
    (attach-tag 'term x))

  (put 'order '(term) order-term)

  (put 'coeff '(term) coeff-term)

  (put 'add '(term term)
       (lambda (t1 t2)
         (tag (add-term t1 t2))))

  (put 'mul '(term term)
       (lambda (t1 t2)
         (tag (mul-term t1 t2))))

  (put 'neg '(term)
       (lambda (term)
         (tag (negate-term term)))) 

  (put '=zero? '(term) zero-term?)

  (put 'make 'term
       (lambda (order coeff)
         (tag (make-term order coeff))))

  'done)

(install-term-package)

(define (make-term order coeff)
  ((get 'make 'term) order coeff))

(define (order term)
  (apply-generic 'order term))

(define (coeff term)
  (apply-generic 'coeff term))


(define (install-sparse-terms-package)
  (define (zero-terms? term-list)
    (null? term-list))

  (define (adjoin-term term term-list)
    (if (=zero? term)
      term-list
      (cons term term-list)))

  (define (first-term term-list)
    (car term-list))

  (define (rest-terms term-list)
    (cdr term-list))

  (define (tag x)
    (attach-tag 'sparse-terms x))

  (put 'adjoin '(term sparse-terms)
       (lambda (term term-list)
         (tag (adjoin-term
                (apply make-term term)
                term-list))))

  (put 'first '(sparse-terms) first-term)
  (put 'rest '(sparse-terms)
       (lambda (term-list)
         (tag (rest-terms term-list))))

  (put '=zero? '(sparse-terms) zero-terms?)

  (put 'make-from-terms 'sparse-terms
       (lambda (terms)
         (tag terms)))

  (put 'make 'sparse-terms
       (lambda (terms)
         (tag terms)))

  'done)

(install-sparse-terms-package)


(define (install-dense-terms-package)
  (define (zero-terms? term-list)
    (null? term-list))

  (define (first-term term-list)
    (make-term
      (- (length term-list) 1)
      (car term-list)))

  (define (rest-terms term-list)
    (cdr term-list))

  (define (adjoin-term term term-list)
    (cond ((=zero? term) term-list)
          ((= (order term) (length term-list))
           (cons (coeff term) term-list))
          (else
            (adjoin-term term (cons 0 term-list)))))

  (define (tag x)
    (attach-tag 'dense-terms x))

  (put 'adjoin '(term dense-terms)
       (lambda (term term-list)
         (tag (adjoin-term
                (apply make-term term)
                term-list))))

  (put 'first '(dense-terms) first-term)

  (put 'rest '(dense-terms)
       (lambda (term-list)
         (tag (rest-terms term-list))))

  (put '=zero? '(dense-terms) zero-terms?)

  (put 'make-from-coeffs 'dense-terms
       (lambda (coeffs)
         (tag coeffs)))

  (put 'make 'dense-terms
       (lambda (coeffs)
         (tag coeffs)))

  'done)

(install-dense-terms-package)


(define (first term-list)
  (apply-generic 'first term-list))

(define (rest term-list)
  (apply-generic 'rest term-list))

(define (adjoin term term-list)
  (apply-generic 'adjoin term term-list))


(define (install-terms-package)
  (define (make-from-coeffs coeffs)
    ((get 'make-from-coeffs 'dense-terms) coeffs))

  (define (make-from-terms terms)
    ((get 'make-from-terms 'sparse-terms) terms))

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

  (define (tag x)
    (attach-tag 'terms x))

  (put 'add '(terms terms)
       (lambda (L1 L2)
         (tag (add-terms L1 L2))))

  (put 'mul '(terms terms)
       (lambda (L1 L2)
         (tag (mul-terms L1 L2))))

  (put 'neg '(terms)
       (lambda (term-list)
         (tag (negate-terms term-list))))

  (put 'make-from-coeffs 'terms
       (lambda (coeffs)
         (tag (make-from-coeffs coeffs))))

  (put 'make-from-terms 'terms
       (lambda (terms)
         (tag (make-from-terms terms))))

  'done)

(install-terms-package)

(define (make-term-list-from-coeffs coeffs)
  ((get 'make-from-coeffs 'terms) coeffs))

(define (make-term-list-from-terms terms)
  ((get 'make-from-terms 'terms) terms))


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

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add (term-list p1)
                      (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul (term-list p1)
                      (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))

  (define (negate-poly p)
    (make-poly
      (variable p)
      (neg (term-list p))))

  (define (sub-poly p1 p2)
    (add-poly p1 (negate-poly p2)))

  (define (zero-poly? p)
    (=zero? (term-list p)))

  (define (tag p)
    (attach-tag 'polynomial p))

  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))

  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))

  (put '=zero? '(polynomial) zero-poly?)

  (put 'neg '(polynomial)
       (lambda (p)
         (tag (negate-poly p))))

  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (sub-poly p1 p2))))

  (put 'make 'polynomial
       (lambda (var terms)
         (tag (make-poly var terms))))

  'done)

(install-polynomial-package)

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))


(add (make-polynomial 'x (make-term-list-from-terms (list (make-term 2 4))))
     (make-polynomial 'x (make-term-list-from-terms (list (make-term 1 2)))))

(mul (make-polynomial 'x (make-term-list-from-terms (list (make-term 2 4))))
     (make-polynomial 'x (make-term-list-from-terms (list (make-term 1 2)))))

(sub (make-polynomial 'x (make-term-list-from-terms (list (make-term 2 4) (make-term 0 7))))
     (make-polynomial 'x (make-term-list-from-terms (list (make-term 2 3) (make-term 0 5)))))


(add (make-polynomial 'x (make-term-list-from-coeffs '(4 0 0)))
     (make-polynomial 'x (make-term-list-from-coeffs '(2 0))))

(mul (make-polynomial 'x (make-term-list-from-coeffs '(4 0 0)))
     (make-polynomial 'x (make-term-list-from-coeffs '(2 0))))

(sub (make-polynomial 'x (make-term-list-from-coeffs '(4 0 7)))
     (make-polynomial 'x (make-term-list-from-coeffs '(3 0 5))))
