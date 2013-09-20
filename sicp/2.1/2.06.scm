(define zero
  (lambda (f)
	(lambda (x) x)))

(define one
  (lambda (f)
	(lambda (x)
	  (f x))))

(define two
  (lambda (f)
	(lambda (x)
	  (f (f x)))))

(define (add m n)
  (lambda (f)
	(lambda (x)
	  ((m f) ((n f) x)))))

(define (inc x)
  (+ x 1))

((zero inc) 1)
((one inc) 1)
((two inc) 1)

(((add one two) inc) 1)
