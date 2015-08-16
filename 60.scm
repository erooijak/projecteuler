#lang scheme

;; The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and 
;; concatenating them in any order the result will always be prime. For example, taking 7 
;; and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents 
;; the lowest sum for a set of four primes with this property.

;; Find the lowest sum for a set of five primes for which any two primes concatenate to 
;; produce another prime.


;; Generate list of primes up to some target number (e.g., 1.000.000)

; Note: set memory limit to 1028 MB.

; Initialize magic variables
(define prime-count 5002)                   ; n as 5002 in prime-sieve returns primes that are less than 10.000
(define prime-count-prime-checker 50000002) ; n = 50.000.002 in prime-sieve returns primes less than 100.000.000 
                                            ; Note: concatenations will be of max length 8 so up to 100 million.
(define max-prime 100000000)                ; Check till that index

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


; Create a hash table with a number as key and if it is prime or not as value
; for fast lookup in prime? method.
(define (make-primes-table input-primes)
  (let loop ((lst input-primes) 
             (acc (make-vector max-prime #f)))
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

; Get all combinations that combine to another prime, with numbers represented as lists
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

; From primes create sets of which constraints are met.

; Try adding new values for each prime in the reduced list of primes with four partners.
; If the prime can be concatenated to the front and back of every prime in the set so far
; (i.e., the resulting pairs are both in the list of pairs) we add the prime and continue 
; to try add a next prime, if this is not possible we discard the previous prime and 
; try the next prime of the list. This stops once we went through all starting primes.
; The result is a list of all combinations that satisfy the constraints.
; Note: this algorithm misses the combinations that are not from lowest to highest if we
;       do not continue the search after having found one.

; www.stackoverflow.com/questions/1869116/
; scheme-built-in-to-check-list-containment#1869196
(define (contains? lst item)
  (if (empty? lst) #f
      (or (equal? (car lst) item) (contains? (cdr lst) item))))

(define (delete item lst) 
  (filter (lambda (x) (not (equal? x item))) lst))

(define (get-all-combinations-that-satisfy-constraints)
  (define (can-be-added? prime set)
    (cond ((null? set) #t)
          ((and (contains? allowed-pairs (list (car set) prime))
                (contains? allowed-pairs (list prime (car set))))
           (can-be-added? prime (cdr set)))
          (else #f)))
  (define (get-combinations-for-start-prime start-prime)
    (let loop ((primes (delete start-prime primes-list-split))
               (acc (list start-prime)))
      (cond ((null? primes) acc)
            ((can-be-added? (car primes) acc)
             (loop (cdr primes) (cons (car primes) acc)))
            (else (loop (cdr primes) acc)))))
  
  (let loop ((primes primes-list-split)
             (result '()))
    (if (null? primes) result
        (let ((combos (get-combinations-for-start-prime (car primes))))
          (if (= 5 (length combos))
              (loop (cdr primes) (cons combos result))
              (loop (cdr primes) result))))))

(define sets-of-primes-for-which-any-two-concatenate-to-another-prime
  (get-all-combinations-that-satisfy-constraints))

; Sum them

; Convert split array representation back to number before summing
(define (make-number-list lst)
  (map (lambda (l) (list->number l)) lst))

(define (sum lst)
 (foldl (lambda (acc e) (+ acc e)) 0 (make-number-list lst)))

(define sums 
  (map (lambda (l) (sum l)) sets-of-primes-for-which-any-two-concatenate-to-another-prime))

; Find the lowest
(define (lowest-of lst)
  (let loop ((lst lst)
             (result (car lst)))
    (if (null? lst) result
        (loop (cdr lst) (min (car lst) result)))))

(define answer (lowest-of sums))

; Print answer
answer