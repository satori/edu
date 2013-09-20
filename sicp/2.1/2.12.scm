(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(define (make-center-percent center tolerance)
  (let ((t (/ tolerance 100.0)))
	(make-interval (* center (- 1 t))
				   (* center (+ 1 t)))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (* 100.0 (/ (width i)
			  (center i))))

(center (make-center-percent 100 10))
(percent (make-center-percent 100 10))
