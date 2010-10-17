(defun restore-variables (&rest variables)
  (setq variables-to-restore (make-hash-table :test 'equal))
  (dolist (variable variables)
    (puthash variable (eval variable) variables-to-restore)))

(restore-variables 'enclose-table 'enclose-remove-pair)

(After
 (maphash
  (lambda (name value)
    (set-variable name value))
  variables-to-restore))
