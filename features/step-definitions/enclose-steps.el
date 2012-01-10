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

(Given "^I add \\(.+\\) as except mode$"
       (lambda (mode)
         (add-to-list 'enclose-except-modes (intern mode))))

(And "^I enable text-mode$"
     (lambda ()
       (text-mode)))
