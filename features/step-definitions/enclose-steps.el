(Given "^enclose mode is active$"
       (lambda ()
         (enclose-mode 1)))

(Then "^the cursor should be between \"\\(.+\\)\" and \"\\(.+\\)\"$"
      (lambda (left right)
        (let ((before (char-to-string (char-before)))
              (after (char-to-string (char-after))))
          (should
           (and
            (equal before left)
            (equal after right))))))

(When "^I place the cursor between \"\\(.+\\)\" and \"\\(.+\\)\"$"
      (lambda (left right)
        (goto-char (point-min))
        (should (search-forward (concat left right) nil t))
        (backward-char 1)))
