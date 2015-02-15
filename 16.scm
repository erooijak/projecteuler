#lang scheme

;; What is the sum of the digits of the number 2^1000?


;; In computing, s-expressions, sexprs or sexps (for "symbolic 
;; expression") are a notation for nested list (tree-structured) 
;; data, invented for and popularized by the programming language
;; Lisp, which uses them for source code as well as data. (1)

;; When representing source code in Lisp, the first element of an
;; S-expression is commonly an operator or function name and any
;; remaining elements are treated as arguments. (1)
(define (pow base exp)
  (define (pow-iter base n result) ;; <= define iterative helper
    (if (= 0 n)                   
        result                    
        (pow-iter base (- n 1) (* base result))))
  (pow-iter base exp 1))

;; In Lisp jargon, the expression "to cons x onto y" means to 
;; construct a new object with (cons x y).
;; The resulting pair has a left half, referred to as the car
;; (the first element), and a right half (the second element), 
;; referred to as the cdr. (2)

;; cdr'ing down a list and consing up the result with map:
(define (map func lst)
  (if (null? lst)
      '() ;; <= if lst is null then return empty list, else
      (cons (func (car lst)) ;; <= apply func to first element
            (map func (cdr lst))))) ;; <= map down the rest

;;Similarly, sum:
(define (sum lst)
  (define (sum-recursive lst result)
    (if (null? lst)
        result ;; <= return result when we added everything
        (sum-recursive (cdr lst) (+ (car lst) result))))
  (sum-recursive lst 0))

;; Map list of characters to a list of integers
;; (Note: #48 is equal to 0 in ASCII so we have to subtract 48)
(define (chars-to-ints char-lst)
  (map (lambda (c) (- (char->integer c) 48)) char-lst))

;; Convert the number to a string, the string to a character list
;; and the character list to an integer list:
(define digits-in-2-to-the-power-of-1000
  (chars-to-ints (string->list (number->string (pow 2 1000)))))

;; Finally, the answer:
(sum digits-in-2-to-the-power-of-1000) ;; => 1366

;; Sources:
;; 1. http://en.wikipedia.org/wiki/S-expression
;; 2. http://en.wikipedia.org/wiki/Cons
