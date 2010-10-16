(let* ((current-directory (file-name-directory load-file-name))
       (features-directory (expand-file-name ".." current-directory))
       (project-directory (expand-file-name ".." features-directory)))
  (setq enclose-root-path project-directory)
  (setq enclose-util-path (expand-file-name "util" project-directory)))

(add-to-list 'load-path enclose-root-path)
(add-to-list 'load-path (expand-file-name "espuds" enclose-util-path))
(add-to-list 'load-path (expand-file-name "emacs-lisp" (expand-file-name "lisp" (expand-file-name "ert" enclose-util-path))))

(require 'enclose)
(require 'espuds)
(require 'ert)

(After
 (setq enclose-remove-pair t))
