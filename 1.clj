;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we
;; get 3, 5, 6 and 9. The sum of these multiples is 23.

;; Find the sum of all the multiples of 3 or 5 below 1000.

(defn divisible-by?
  [divisor x]
  (zero? (mod x divisor)))

(->> (range 1000)
     (reduce #(if (or (divisible-by? 5 %2)
                      (divisible-by? 3 %2))
                (+ %1 %2)
                %1))
     println)

