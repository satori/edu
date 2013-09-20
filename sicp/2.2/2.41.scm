(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
	nil
	(cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))

(define (unique-triples n)
  (flatmap
	(lambda (i)
	  (flatmap
		(lambda (j)
		  (map (lambda (k) (list i j k))
			   (enumerate-interval 1 (- j 1))))
		(enumerate-interval 1 (- i 1))))
	(enumerate-interval 1 n)))

(define (sum-triples s n)
  (filter (lambda (t) (= s (fold-right + 0 t)))
		  (unique-triples n)))
