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

(define (count-pairs x)

  (define (encountered? item lst)
    (cond ((null? lst) #f)
          ((eq? item (car lst)) #t)
          (else (encountered? item (cdr lst)))))

  (let ((encountered '()))
    (define (counter x)
      (if (or (not (pair? x))
              (encountered? x encountered))
        0
        (begin
          (set! encountered (cons x encountered))
          (+ (counter (car x))
             (counter (cdr x))
             1))))

    (counter x)))

(define a (cons 1 2))
(define b (cons 3 4))
(define c (cons a b))

(count-pairs c) ; 3 pairs

(set-cdr! a b)

(count-pairs c) ; 3 pairs

(set-car! a b)
(set-cdr! c a)

(count-pairs c) ; 3 pairs

(set-cdr! b a)

(count-pairs c); 3 pairs
