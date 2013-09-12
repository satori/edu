(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch x)
  (car x))

(define (right-branch x)
  (car (cdr x)))

(define (branch-length x)
  (car x))

(define (branch-structure x)
  (car (cdr x)))

(define (total-weight x)
  (cond ((not (pair? x)) x)
		(else (+ (total-weight (branch-structure (left-branch x)))
				 (total-weight (branch-structure (right-branch x)))))))

(define (branch-torque x)
  (* (branch-length x)
	 (total-weight (branch-structure x))))

(define (balanced? x)
  (cond ((not (pair? x)) #t)
		(else (and (= (branch-torque (left-branch x))
					  (branch-torque (right-branch x)))
				   (balanced? (branch-structure (left-branch x)))
				   (balanced? (branch-structure (right-branch x)))))))

(left-branch (make-mobile (make-branch 1 10) (make-branch 2 5)))
(right-branch (make-mobile (make-branch 1 10) (make-branch 2 5)))

(branch-length (make-branch 1 10))
(branch-structure (make-branch 1 10))

(total-weight (make-mobile (make-branch 1 10) (make-branch 2 5)))

(balanced? (make-mobile (make-branch 1 10) (make-branch 2 5)))

(balanced? (make-mobile
			 (make-branch 1 (make-mobile
							  (make-branch 2 5)
							  (make-branch 1 10)))
			 (make-branch 3 3)))

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (right-branch x)
  (cdr x))

(define (branch-structure x)
  (cdr x))

(left-branch (make-mobile (make-branch 1 10) (make-branch 2 5)))
(right-branch (make-mobile (make-branch 1 10) (make-branch 2 5)))

(branch-length (make-branch 1 10))
(branch-structure (make-branch 1 10))

(total-weight (make-mobile (make-branch 1 10) (make-branch 2 5)))

(balanced? (make-mobile (make-branch 1 10) (make-branch 2 5)))

(balanced? (make-mobile
			 (make-branch 1 (make-mobile
							  (make-branch 2 5)
							  (make-branch 1 10)))
			 (make-branch 3 3)))
