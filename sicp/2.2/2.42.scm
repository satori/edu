(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
	nil
	(cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))

(define empty-board nil)

(define (make-position row col)
  (cons row col))

(define (position-row p)
  (car p))

(define (position-col p)
  (cdr p))

(define (adjoin-position row column rest)
  (append rest (list (make-position row column))))

(define (safe? col positions)
  (let ((current (list-ref positions (- col 1)))
		(other (filter (lambda (p) (not (= (position-col p) col)))
					   positions)))
	(= 0 (length (filter (lambda (p)
						   (or (= (position-row p) (position-row current))
							   (= (abs (- (position-row p) (position-row current)))
								  (abs (- (position-col p) (position-col current))))))
						 other)))))

(define (queens board-size)
  (define (queen-cols k)
	(if (= k 0)
	  (list empty-board)
	  (filter
		(lambda (positions) (safe? k positions))
		(flatmap
		  (lambda (rest-of-queens)
			(map (lambda (new-row)
				   (adjoin-position new-row k rest-of-queens))
				 (enumerate-interval 1 board-size)))
		  (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 8)
