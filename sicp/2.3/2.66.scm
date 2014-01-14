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

(define entry car)
(define left-branch cadr)
(define right-branch caddr)

(define make-tree list)

(define make-record cons)
(define key car)
(define data cdr)

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((= given-key (key (car set-of-records)))
         (car set-of-records))
        ((< given-key (key (car set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        ((> given-key (key (car set-of-records)))
         (lookup given-key (right-branch set-of-records)))))

(define database (make-tree (make-record 5 "Ben Bitdiddle")
                            (make-tree (make-record 3 "Eva Lu Ator")
                                       (make-tree (make-record 1 "Louis Reasoner")
                                                  '()
                                                  '())
                                       '())
                            (make-tree (make-record 9 "Alyssa P. Hacker")
                                       (make-tree (make-record 7 "Cy D. Fect")
                                                  '()
                                                  '())
                                       (make-tree (make-record 11 "Lem E. Tweakit")
                                                  '()
                                                  '()))))

(lookup 9 database)
