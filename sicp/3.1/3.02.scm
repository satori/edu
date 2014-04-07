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

(define (make-monitored func)
  (let ((counter 0))
    (define (dispatch arg)
      (cond ((eq? arg 'how-many-calls?) counter)
            ((eq? arg 'reset-count) (set! counter 0))
            (else
              (begin (set! counter (+ counter 1))
                     (func arg)))))
    dispatch))

(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)

(s 'reset-count)

(s 'how-many-calls?)
