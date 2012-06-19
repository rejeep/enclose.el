(defun enclose-before-word-context ()
  "Enclose when at beginning of word."
  (looking-at "[a-zA-Z0-9]+"))

(defun enclose-end-of-line-context ()
  "Do not enclose when at end of line."
  (not (equal (point) (line-end-position))))
