(load "2.67.scm")

(define (element-of-set? x set)
  (cond ((null? set) #f)
		((equal? x (car set)) #t)
		(else (element-of-set? x (cdr set)))))

(define (encode message tree)
  (if (null? message)
	'()
	(append (encode-symbol (car message) tree)
			(encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
	'()
	(cond ((element-of-set? symbol (symbols (left-branch tree)))
		   (cons 0 (encode-symbol symbol (left-branch tree))))
		  ((element-of-set? symbol (symbols (right-branch tree)))
		   (cons 1 (encode-symbol symbol (right-branch tree))))
		  (else (error "bad symbol -- ENCODE-SYMBOL" symbol)))))

(decode (encode (decode sample-message sample-tree) sample-tree) sample-tree)
