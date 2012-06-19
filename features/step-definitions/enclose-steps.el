(Given "^I turn on enclose globaly$"
       (lambda ()
         (enclose-global-mode 1)))

(Given "^I turn on enclose$"
       (lambda ()
         (enclose-mode 1)))

(Given "^I turn off enclose$"
       (lambda ()
         (enclose-mode -1)))

(Given "^remove pair option is disabled$"
       (lambda ()
         (setq enclose-remove-pair nil)))

(Given "^I add encloser \"\\(.\\)/\\(.\\)\"$"
       (lambda (left right)
         (enclose-add-encloser left right)))

(Given "^I add encloser \"\\(.\\)/\\(.\\)\" with context \"\\(.+\\)\"$"
       (lambda (left right context)
         (let ((fn (intern context)))
           (enclose-add-encloser left right nil fn))))

(Given "^I remove encloser \"\\(.\\)\"$"
       (lambda (left)
         (enclose-remove-encloser left)))

(Given "^I add \"\\(.+\\)\" as an except mode$"
       (lambda (mode)
         (add-to-list 'enclose-except-modes (intern mode))))

(When "^I go to end of line$"
       (lambda ()
         (call-interactively 'move-end-of-line)))
 
(When "^I go to beginning of line$"
       (lambda ()
         (call-interactively 'move-beginning-of-line)))

(Then "^the key \"\\(.+\\)\" should not be bound by enclose$"
       (lambda (key)
         (should (equal (key-binding key) 'self-insert-command))))
