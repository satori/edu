(load "2.68.scm")

(define (adjoin-set x set)
  (cond ((null? set) (list x))
		((< (weight x) (weight (car set)))
		 (cons x set))
		(else (cons (car set)
					(adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
	'()
	(let ((pair (car pairs)))
	  (adjoin-set (make-leaf (car pair)
							 (cadr pair))
				  (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaves)
  (if (null? (cdr leaves))
	(car leaves)
	(successive-merge
	  (adjoin-set
		(make-code-tree (car leaves)
						(cadr leaves))
		(cddr leaves)))))

(decode sample-message (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
