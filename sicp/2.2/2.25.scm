(define x1 (list 1 3 (list 5 7) 9))
(define x2 (list (list 7)))
(define x3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(car (cdr (car (cdr (cdr x1)))))
(car (car x2))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr x3))))))))))))
