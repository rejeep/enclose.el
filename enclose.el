;;; enclose.el --- Enclose cursor within punctuations

;; Copyright (C) 2010 Johan Andersson

;; Author: Johan Andersson <johan.rejeep@gmail.com>
;; Maintainer: Johan Andersson <johan.rejeep@gmail.com>
;; Version: 0.0.1
;; Keywords: speed, convenience
;; URL: http://github.com/rejeep/enclose.el

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:

(defvar enclose-table
  (let ((table (make-hash-table :test 'equal)))
    (puthash "\"" "\"" table)
    (puthash "'"  "'"  table)
    (puthash "("  ")"  table)
    (puthash "{"  "}"  table)
    (puthash "["  "]"  table)
    table)
  "Table with enclosing punctuations.")

(defvar enclose-mode-map (make-sparse-keymap)
  "Keymap for `enclose-mode'.")

(defconst enclose-del-key "DEL"
  "Delete key.")


(defun enclose-insert (left)
  "Insert LEFT, it's right buddy and places the cursor between."
  (interactive)
  (let ((right (gethash left enclose-table)))
    (insert left)
    (insert right)
    (backward-char 1)))

(defun enclose-remove-fallback ()
  "When enclose remove is not to be used."
  (let ((enclose-mode nil))
    (call-interactively (key-binding (edmacro-parse-keys enclose-del-key)))))

(defun enclose-remove ()
  "Removes char before and after, if matching."
  (interactive)
  (let ((before (char-before)) (after (char-after)))
    (if (and before after)
        (if (equal (gethash (char-to-string before) enclose-table) (char-to-string after))
            (delete-region (- (point) 1) (+ (point) 1))
          (enclose-remove-fallback))
      (enclose-remove-fallback))))

(defun enclose-define-keys ()
  "Defines key bindings."
  (define-key enclose-mode-map (edmacro-parse-keys enclose-del-key) 'enclose-remove)
  (maphash
   (lambda (binding _)
     (define-key enclose-mode-map (edmacro-parse-keys binding)
       `(lambda ()
          (interactive)
          (enclose-insert ,binding))))
   enclose-table))

;;;###autoload
(define-minor-mode enclose-mode
  "Drag stuff around."
  :init-value nil
  :lighter " enc"
  :keymap enclose-mode-map
  (when enclose-mode
    (enclose-define-keys)))

;;;###autoload
(defun turn-on-enclose-mode ()
  "Turn on `enclose-mode'"
  (interactive)
  (enclose-mode +1))

;;;###autoload
(defun turn-off-enclose-mode ()
  "Turn off `enclose-mode'"
  (interactive)
  (enclose-mode -1))

;;;###autoload
(define-globalized-minor-mode enclose-global-mode
  enclose-mode
  turn-on-enclose-mode)


(provide 'enclose)

;;; enclose.el ends here
