#lang scheme

;; The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and 
;; concatenating them in any order the result will always be prime. For example, taking 7 
;; and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents 
;; the lowest sum for a set of four primes with this property.

;; Find the lowest sum for a set of five primes for which any two primes concatenate to 
;; produce another prime.


;; Generate list of primes up to some target number (e.g., 1.000.000)

(define (prime? n)
  (define (check-divisible n divisor)
    (cond ((= divisor 1) #t)
          ((= 0 (modulo n divisor)) #f)
          (else (check-divisible n (- divisor 1)))))
  (cond ((<= n 1) #f)
        ((= n 2) #t)
        ((even? n) #f)
        (else (check-divisible n (truncate (sqrt n))))))

(define (generate-primes n)
  (cond ((< n 3) (error "generate-primes: contract violation, n needs to be 3 or higher"))
        ((even? n) (generate-primes (- n 1)))
        ((= n 3) (list 3 2))
        ((prime? n) (cons n (generate-primes (- n 2))))
        (else (generate-primes (- n 2)))))

; Note: above is too slow. Need a faster prime generation algorithm 
; so using below from the web:

; Copyright (C) 2011 Toby Thain, toby@telegraphics.com.au
(define (primes-up-to n)
  (let ((sieve (make-vector (+ n 1) #t)))
    (define (test-prime i)
      (define (is-prime? idx)
        (vector-ref sieve idx))
      (define (not-prime! idx)
        (vector-set! sieve idx #f))
      (define (remove-multiples i step)
        (when (<= i n)
          (not-prime! i)
          (remove-multiples (+ i step) step)))
      (if (> i n)
          '()
          (if (is-prime? i)
              (begin
                (remove-multiples i i)
                (cons i (test-prime (+ i 1))))
              (test-prime (+ i 1)))))
    (test-prime 2)))

(define primes-list (primes-up-to 1000))


;; From list generate split arrays of allowed pairs

; www.stackoverflow.com/questions/12834562/scheme-number-to-list#12841962
(define (number->list n)
  (let loop ((n n) (acc '()))
    (if (< n 10)
        (cons n acc)
        (loop (quotient n 10)
              (cons (remainder n 10) acc)))))

; www.stackoverflow.com/questions/1683479/how-to-convert-a-list-to-num-in-scheme#1688960
(define (list->number lst)
  (let loop ((n 0) (lst lst))
    (if (empty? lst)
        n
        (loop (+ (* 10 n) (car lst)) (cdr lst)))))

(define primes-list-split 
  (map number->list primes-list))

(define (prime-pairs lst)
  (define (split lst pos)
    (list (drop-right lst pos) (take-right lst pos)))
  (define (prime-pairs-iter n acc)
    (if (zero? n) 
        (if 
         (or (null? acc) 
             (zero? (caar acc)) 
             (zero? (caadr acc)) 
             (> (length acc) 2)) 
         '() 
         (list acc))
        (prime-pairs-iter 
         (- n 1) 
         (let ((s (split lst n)))
           (if (and (prime? (list->number (car s)))
                    (prime? (list->number (cadr s))))
               (append s acc)
               acc)))))
  (prime-pairs-iter (- (length lst) 1) '()))

(define split-array-of-allowed-pairs 
  (append-map prime-pairs primes-list-split))


;; Use list of pairs for efficient search for groups of five that satisfy constraints

; Create list of unique first items in the pairs 
(define (get-first-elements lst)
  (if (null? lst) '()
      (cons (caar lst) (get-first-elements (cdr lst)))))

(define (remove-duplicates lst)
  (foldr (lambda (x y) (cons x (filter (lambda (z) (not (equal? x z))) y))) empty lst))

(define list-of-unique-first-primes 
  (remove-duplicates (get-first-elements split-array-of-allowed-pairs)))

; Create hash keyed by starting prime with all primes it can pair with.

; www.stackoverflow.com/questions/1869116/
; scheme-built-in-to-check-list-containment#1869196
(define (contains? lst item)
  (if (empty? lst) #f
      (or (equal? (first lst) item) (contains? (cdr lst) item))))

(define (delete item lst) 
  (filter (lambda (x) (not (equal? x item))) lst))

(define (get-primes-that-pair prime pairs)
  (if (null? pairs) '()
      (append (if (contains? (car pairs) prime)
                  (delete prime (car pairs))
                  '())
              (get-primes-that-pair prime (cdr pairs)))))

; Creates hash where car is prime key and cdr is unique prime values that pair.
(define (create-hash-of-primes-with-primes-that-pair primes prime-pairs)
  (map (lambda (p) 
         (remove-duplicates
          (cons p (get-primes-that-pair p prime-pairs)))) primes))

(create-hash-of-primes-with-primes-that-pair 
 list-of-unique-first-primes split-array-of-allowed-pairs)

; Exclude primes with less than four potential partners.

; TODO!

; Only keep sets of which the constraints are met.

; TODO!

; Sum them
(define (sum lst)
  (if (null? lst) 0
      (+ (car lst) (sum (cdr lst)))))

; TODO!

; Find the largest

; TODO!

; Print answer

; TODO!