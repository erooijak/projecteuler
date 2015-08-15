#lang scheme

;; The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and 
;; concatenating them in any order the result will always be prime. For example, taking 7 
;; and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents 
;; the lowest sum for a set of four primes with this property.

;; Find the lowest sum for a set of five primes for which any two primes concatenate to 
;; produce another prime.


;; Generate list of primes up to some target number (e.g., 1.000.000)

; Initialize magic variables
(define prime-count 500)                  ; The first 500 primes are less than 1.000
(define prime-count-prime-checker 500001) ; Primes up to 1.000.003 (concatenations won't go higher)
(define max-index-to-check 1000004)       ; One higher than 1.000.003

; http://stackoverflow.com/questions/32019820/return-vector-fixed-length
; -array-from-prime-sieve-function-and-convert-it-to-l/32021058#32021058
(define (prime-sieve n)
  (define vec (make-vector (+ n 1) #t))
  (let loop ((p 3)          ; Maintains invariant p = 2j + 1
             (q 4)          ; Maintains invariant q = 2j + 2jj
             (j 1)
             (result '(2))) ; Start with 2, is missed otherwise
    (define (lp result)
      (loop (+ p 2)
            (+ q p p 2)
            (+ j 1)
            result))
    (define (eradicate!)
      (do ((q q (+ q p)))
        ((> q n))
        (vector-set! vec q #f)))
    
    (cond ((> j n) (reverse result))
          ((vector-ref vec j) (eradicate!)
                              (lp (cons p result)))
          (else (lp result)))))

(define primes-list 
  (prime-sieve prime-count))

(define primes-list-for-prime-checker
  (prime-sieve prime-count-prime-checker))

; Create a hash table with key a number and value if it is prime or not
; for fast lookup in prime? method.
(define (make-primes-table input-primes)
  (let loop ((lst input-primes) 
             (acc (make-vector max-index-to-check #f)))
    (if (empty? lst)
        acc
        (begin 
          (vector-set! acc (car lst) #t)
          (loop (cdr lst) acc)))))

(define primes-table 
  (make-primes-table primes-list-for-prime-checker))

; Checks for primes upto the highest number.
(define (prime? x)
  (vector-ref primes-table x))


;; From list generate split arrays of allowed pairs

; Note: split array means that the primes are represented as lists, e.g.,
;       the concatenation of the prime 211 is represented as ((2) (1 1)).

; www.stackoverflow.com/questions/12834562/scheme-number-to-list#12841962
(define (number->list n)
  (let loop ((n n) 
             (acc '()))
    (if (< n 10)
        (cons n acc)
        (loop (quotient n 10)
              (cons (remainder n 10) acc)))))

; www.stackoverflow.com/questions/1683479/how-to-convert-a-list-to-num-in-scheme#1688960
(define (list->number lst)
  (let loop ((n 0) 
             (lst lst))
    (if (empty? lst)
        n
        (loop (+ (* 10 n) (car lst)) (cdr lst)))))

(define primes-list-split 
  (map number->list primes-list))

(define (get-prime-pairs lst)
  (define (find-all-prime-pairs prime lst)
    (let loop ((prime prime) 
               (lst lst) 
               (acc '()))
      (if (null? lst) acc
          (if (prime? (list->number (append prime (car lst))))
              (loop prime (cdr lst) (cons (list prime (car lst)) acc))
              (loop prime (cdr lst) acc)))))
  (append-map (lambda (x) (find-all-prime-pairs x lst)) lst))

(define allowed-pairs (get-prime-pairs primes-list-split))


;; Use list of pairs for efficient search for groups of five that satisfy constraints

; Create list of unique first items in the pairs.
(define (get-first-elements lst)
  (if (null? lst) '()
      (cons (caar lst) (get-first-elements (cdr lst)))))

(define (remove-duplicates lst)
  (foldr (lambda (x y) (cons x (filter (lambda (z) (not (equal? x z))) y))) empty lst))

(define list-of-unique-first-primes 
  (remove-duplicates (get-first-elements allowed-pairs)))

; Create hash keyed by starting prime with all primes it can pair with.

(define (delete item lst) 
  (filter (lambda (x) (not (equal? x item))) lst))

; www.stackoverflow.com/questions/1869116/
; scheme-built-in-to-check-list-containment#1869196
(define (contains? lst item)
  (if (empty? lst) #f
      (or (equal? (car lst) item) (contains? (cdr lst) item))))

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

(define hash-keyed-by-starting-prime 
  (create-hash-of-primes-with-primes-that-pair 
   list-of-unique-first-primes allowed-pairs))

; Exclude primes with less than four potential partners.
(define (get-primes-with-more-than-four-partners hash-lst)
  (get-first-elements (filter (lambda (x) (> (length x) 3)) hash-lst)))

(define primes-with-more-than-four-partners 
  (get-primes-with-more-than-four-partners hash-keyed-by-starting-prime))

; From primes create sets of which constraints are met.

; Try adding new values for each prime in the reduced list of primes with four partners.
; If the prime can be concatenated to the front and back of every prime in the set so far
; (i.e., the resulting pairs are both in the list of pairs) we add the prime and continue 
; to try add a next prime, if this is not possible we discard the previous prime and 
; try the next prime of the list. This stops once we went through all starting primes.
; The result is a list of all combinations that satisfy the constraints.
; Note: this algorithm misses the combinations that are not from lowest to highest if we
;       do not continue the search after having found one.

; Takes as input a prime in list form, a list of those primes and a list of prime pairs.
(define (can-be-added? prime set lst-of-pairs)
  (cond ((null? set) #t)
        ((and (contains? lst-of-pairs (list (car set) prime))
              (contains? lst-of-pairs (list prime (car set))))
         (can-be-added? prime (cdr set) lst-of-pairs))
        (else #f)))

(define (get-all-combinations-that-satisfy-constraints primes lst-of-pairs)
  (define (get-combinations-for-start-prime start-prime)
    (let loop ((primes primes)
               (acc '()))
      (cond ((null? primes) acc)
            ((can-be-added? (car primes) acc lst-of-pairs)
             (loop (cdr primes) (append (car primes) acc)))
            (else (loop (cdr primes) acc)))))
  
  (let loop ((primes primes)
             (result '()))
    (cond ((null? primes) result)
          (= 4 (length (get-combinations-for-start-prime (car primes)))
           (loop (cdr primes) (append (get-combinations-for-start-prime (car primes)) result)))
          (else (loop (cdr primes) result)))))

(get-all-combinations-that-satisfy-constraints primes-with-more-than-four-partners allowed-pairs)

; Sum them
(define (sum lst)
  (if (null? lst) 0
      (+ (car lst) (sum (cdr lst)))))

; TODO!

; Find the largest

; TODO!

; Print answer

; TODO!