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

(define (filtered-accumulate combiner null-value term a next b filter?)
  (if (> a b)
    null-value
    (combiner (cond ((filter? a)
                     (term a))
                    (else null-value))
              (filtered-accumulate combiner null-value term (next a) next b filter?))))

(define (inc x)
  (+ x 1))

(define (sum-prime-squares a b)
  (define (square x)
    (* x x))

  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (find-divisor n test-divisor)
    (define (next n)
      (cond ((= n 2) 3)
            (else (+ n 2))))

    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))

  (define (divides? a b)
    (= (remainder b a) 0))

  (define (prime? n)
    (= n (smallest-divisor n)))

  (filtered-accumulate + 0 square a inc b prime?))

(define (product-relative-prime n)
  (define (identity x) x)

  (define (filter? x)
    (= 1 (gcd n x)))

  (filtered-accumulate * 1 identity 1 inc (- n 1) filter?))
