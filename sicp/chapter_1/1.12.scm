(define (pascal-triangle n k)
  (cond ((and (= n 0) (= k 0)) 1)
        ((or (< n 0) (< k 0)) 0)
        (else (+ (pascal-triangle (- n 1) (- k 1))
                 (pascal-triangle (- n 1) k)))))
