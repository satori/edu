(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) '()))

(define (attach-tag type-tag contents)
  (if (number? contents)
	contents
	(cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
		((pair? datum) (car datum))
		(else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
		((pair? datum) (cdr datum))
		(else (error "Bad tagged datum -- CONTENTS" datum))))

(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (mul x y)
  (apply-generic 'mul x y))

(define (div x y)
  (apply-generic 'div x y))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
	(let ((proc (get op type-tags)))
	  (if proc
		(apply proc (map contents args))
		(error
		  "No method for these types -- APPLY-GENERIC"
		  (list op type-tags))))))

(define (install-scheme-number-package)
  (define (tag x)
	(attach-tag 'scheme-number x))

  (put 'add '(scheme-number scheme-number)
	   (lambda (x y) (tag (+ x y))))

  (put 'sub '(scheme-number scheme-number)
	   (lambda (x y) (tag (- x y))))

  (put 'mul '(scheme-number scheme-number)
	   (lambda (x y) (tag (* x y))))

  (put 'div '(scheme-number scheme-number)
	   (lambda (x y) (tag (/ x y))))

  (put 'make 'scheme-number
	   (lambda (x) (tag x)))

  'done)

(install-scheme-number-package)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(add 1 2)
