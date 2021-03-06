;; NOTE: Assertions have been generated by update_lit_checks.py and should not be edited.
;; RUN: wasm-opt %s --merge-blocks -all -S -o - \
;; RUN:   | filecheck %s

(module
 (type $anyref_=>_none (func (param anyref)))
 ;; CHECK:      (func $br_on_to_drop
 ;; CHECK-NEXT:  (nop)
 ;; CHECK-NEXT:  (drop
 ;; CHECK-NEXT:   (block $label$1 (result (ref null i31))
 ;; CHECK-NEXT:    (drop
 ;; CHECK-NEXT:     (br_on_i31 $label$1
 ;; CHECK-NEXT:      (ref.null any)
 ;; CHECK-NEXT:     )
 ;; CHECK-NEXT:    )
 ;; CHECK-NEXT:    (ref.null i31)
 ;; CHECK-NEXT:   )
 ;; CHECK-NEXT:  )
 ;; CHECK-NEXT: )
 (func $br_on_to_drop
  (nop) ;; ensure a block at the function level
  (drop
   (block $label$1 (result (ref null i31)) ;; this block type must stay, we
                                           ;; cannot remove it due to the br_on
    (drop
     (br_on_i31 $label$1
      (ref.null any)
     )
    )
    (ref.null i31) ;; this must not end up dropped
   )
  )
 )
)
