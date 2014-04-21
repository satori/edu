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

(define (make-deque)
  (cons '() '()))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" deque)
    (car (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "REAR called with an empty deque" deque)
    (car (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons item (cons '() '()))))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair))
          (else
            (set-cdr! (cdr new-pair) (front-ptr deque))
            (set-car! (cdr (front-ptr deque)) new-pair)
            (set-front-ptr! deque new-pair)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item (cons '() '()))))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair))
          (else
            (set-car! (cdr new-pair) (rear-ptr deque))
            (set-cdr! (cdr (rear-ptr deque)) new-pair)
            (set-rear-ptr! deque new-pair)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE! called with an empty deque" deque))
        (else
          (set-front-ptr! deque (cddr (front-ptr deque)))
          (set-car! (cdr (front-ptr deque)) '()))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE! called with an empty deque" deque))
        (else
          (set-rear-ptr! deque (cadr (rear-ptr deque)))
          (set-cdr! (cdr (rear-ptr deque)) '()))))

(define (print-deque deque)
  (define (print-items item)
    (display (car item))
    (cond ((not (null? (cddr item)))
           (display " ")
           (print-items (cddr item)))))

  (display "(")
  (cond ((empty-deque? deque)
         (display ""))
        (else
          (print-items (front-ptr deque))))
  (display ")")
  (newline))

(define d1 (make-deque))

(front-insert-deque! d1 'a)

(print-deque d1)

(rear-insert-deque! d1 'b)

(print-deque d1)

(rear-insert-deque! d1 'c)

(print-deque d1)

(front-delete-deque! d1)

(print-deque d1)

(rear-delete-deque! d1)

(print-deque d1)

(rear-delete-deque! d1)
