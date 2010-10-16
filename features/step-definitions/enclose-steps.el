(Given "^enclose mode is active$"
       (lambda ()
         (enclose-mode 1)))

(And "^the cursor should be between \"\\(.+\\)\" and \"\\(.+\\)\"$"
     (lambda (left right)
       (let ((before (char-to-string (char-before)))
             (after (char-to-string (char-after))))
         (should
          (and
           (equal before left)
           (equal after right))))))
