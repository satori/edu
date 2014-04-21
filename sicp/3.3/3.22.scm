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

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (empty-queue?)
      (null? front-ptr))

    (define (front-queue)
      (if (empty-queue?)
        (error "FRONT called with an empty queue")
        (car front-ptr)))

    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               dispatch)
              (else
                (set-cdr! rear-ptr new-pair)
                (set! rear-ptr new-pair)
                dispatch))))

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
              (set! front-ptr (cdr front-ptr))
              dispatch)))

    (define (print-queue)
      (display front-ptr))

    (define (dispatch m)
      (cond ((eq? m 'empty?) empty-queue?)
            ((eq? m 'front) front-queue)
            ((eq? m 'insert!) insert-queue!)
            ((eq? m 'delete!) delete-queue!)
            ((eq? m 'print) print-queue)
            (else
              (error "QUEUE -- unknown method"))))

    dispatch))

(define q1 (make-queue))

((q1 'insert!) 'a)
((q1 'insert!) 'b)

((q1 'delete!))
((q1 'delete!))

((q1 'print))
