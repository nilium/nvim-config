; com
;
; Contains common functions used elsewhere across my neovim config. Kind of like
; plenary but different.

(local unpack (or _G.table.unpack _G.unpack))

(lambda max [n ...]
  "Returns the largest number passed to min."
  (match (select "#" ...)
    0 n
    1 (let [other ...] (if (> n other) n other))
    _ (let [[other & rest] [...]]
        (max (if (> n other) n other) (unpack rest)))))

(lambda min [n ...]
  "Returns the smallest number passed to min."
  (match (select "#" ...)
    0 n
    1 (let [other ...] (if (< n other) n other))
    _ (let [[other & rest] [...]]
        (min (if (< n other) n other) (unpack rest)))))

(lambda range [n to ?step]
  "Returns an iterator over numbers ranging from n through to, inclusive, with an optional step (defaults to 1)."
  (let [step (or ?step 1)]
   (local next-fn #(let [r (+ $2 step)] (when (<= r to) r)))
   (var step-fn nil)
   (set step-fn #(do (set step-fn next-fn) $2))
   (values #(step-fn $...) nil n)))

(fn values-iter [...]
  "Returns an iterator over values passed in as varargs."
  (let [nargs (select :# ...) args [...]]
    (values
      (fn [state _]
        (let [{: n} state]
          (when (<= n nargs)
            (set state.n (+ n 1))
            (. args n))))
      {:n 1}
      nil)))

(lambda value-map [map-fn ...]
  "Given a sequence of values, map them using map-fn and return them as values."
  (let [args [...] nargs (select :# ...)]
    (for [i 1 nargs] (tset args i (map-fn (. args i))))
    (values (unpack args))))

(fn nil? [...]
  "Returns true for each value that is nil, and false for each value that isn't."
  (if (= 1 (select :# ...))
    (= nil ...)
    (values (value-map #(= nil $1) ...))))

; Generate table?, function?, etc.
(lambda gen-typename? [typename]
  (fn [...]
    (if (= 1 (select :# ...))
        (= typename (type ...))
        (value-map #(= typename (type $1)) ...))))

(local table? (gen-typename? :table))
(local function? (gen-typename? :function))
(local string? (gen-typename? :string))
(local number? (gen-typename? :number))
(local boolean? (gen-typename? :boolean))

(fn is-integer? [n] (and (number? n) (= (math.floor n) n)))
(fn integer? [...]
  "Returns true for each value that is an integer, and false for each value that isn't."
  (if (= 1 (select :# ...))
    (is-integer? ...)
    (values (value-map is-integer? ...))))

(fn array? [tbl]
  "Returns true if a table has strictly integer-based keys."
  (accumulate [array true
               key _
               (pairs tbl)
               :until (not array)]
    (is-integer? key)))

(lambda array-length [tbl]
  "Returns the length of array-like tables. Does not verify if the table is array-like."
  (accumulate [max-i 0
               i _
               (pairs tbl)]
    (if (number? i) (max max-i i) max-i)))

(lambda array-pairs [tbl]
  "Returns an iterator over the indices and values from 1 to the length of the array."
  (let [len (array-length tbl)
        state {: len}]
    (values
      #(match $1
         (where {: len} (< $2 len))
         (let [idx (+ $2 1)]
           (values idx (. tbl idx)))
         _ nil)
      state
      0)))

(lambda first [tbl]
  "Returns the first element of an array-like table (i.e., index 1)."
  (. tbl 1))

(lambda last [tbl]
  "Returns the last element of an array-like table."
  (. tbl (array-length tbl)))

(fn tail [tbl]
  "Returns a table of all but the first value in an array (i.e., with all indices shifted by -1). If tbl is either empty or not a table, returns nil."
  (match tbl
    [_ & rest] rest
    _ nil))

(fn keys [tbl]
  "Returns an array of keys in the given table."
  (icollect [k _ (pairs tbl)] k))


{; Iterators
 : values-iter
 : range
 ; Mapping
 : value-map
 ; Type checks
 : nil?
 : table?
 : function?
 : string?
 : number?
 : integer?
 : boolean?
 ; Tables
 : keys
 ; Arrays
 : array?
 : array-length
 : array-pairs
 : first
 : last
 : tail}
