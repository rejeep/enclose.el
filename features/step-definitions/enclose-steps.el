(Given "^enclose mode is active$"
       (lambda ()
         (enclose-mode 1)))

(Given "^remove pair option is disabled$"
       (lambda ()
         (setq enclose-remove-pair nil)))

(Given "^I add encloser \"\\(.\\)/\\(.\\)\"$"
       (lambda (left right)
         (enclose-add-encloser left right)))

(Given "^I remove encloser \"\\(.\\)\"$"
       (lambda (left)
         (enclose-remove-encloser left)))

(When "^I enable the global mode$"
      (lambda ()
        (enclose-global-mode 1)))

;; TODO: Submit below to Espuds

(When "^I switch to buffer \"\\(.+\\)\"$"
      (lambda (buffer)
        (let ((v (vconcat [?\C-x ?b] (string-to-vector buffer))))
          (execute-kbd-macro v))))

(Then "^the cursor should be after \"\\(.+\\)\"$"
      (lambda (right)
        (should (looking-back (regexp-quote right)))))

(Then "^the cursor should be before \"\\(.+\\)\"$"
      (lambda (left)
        (should (looking-at (regexp-quote left)))))


(Then "^the cursor should be between \"\\(.+\\)\" and \"\\(.+\\)\"$"
      (lambda (left right)
        (should
         (and
          (looking-back (regexp-quote left))
          (looking-at (regexp-quote right))))))

(When "^I place the cursor between \"\\(.+\\)\" and \"\\(.+\\)\"$"
      (lambda (left right)
        (goto-char (point-min))
        (should (search-forward (concat left right) nil t))
        (backward-char (length right))))

(When "^I go to beginning of buffer$" 'beginning-of-buffer)

(When "^I go to end of buffer$" 'end-of-buffer)

(Then "I should not see anything"
      (lambda ()
        (should (equal (buffer-size) 0))))

(When "^I turn on \\(.+\\)$"
      (lambda (mode)
        (let ((v (vconcat [?\C-u 1 ?\M-x] (string-to-vector mode))))
          (execute-kbd-macro v))))
