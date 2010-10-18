;;; enclose.el --- Enclose cursor within punctuation pairs

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

(eval-when-compile
  (require 'cl))

(defvar enclose-table
  (let ((table (make-hash-table :test 'equal)))
    (puthash "\"" "\"" table)
    (puthash "'"  "'"  table)
    (puthash "("  ")"  table)
    (puthash "{"  "}"  table)
    (puthash "["  "]"  table)
    table)
  "Table with encloser pairs.")

(defvar enclose-mode-map (make-sparse-keymap)
  "Keymap for `enclose-mode'.")

(defvar enclose-remove-pair t
  "Decides if pair should be removed, or just the left one.")

(defconst enclose-del-key "DEL"
  "Delete key.")

(defconst enclose-anti-regex "[a-zA-Z0-9]+"
  "Enclosing functionality should not be activated when surrounded by
this regex.")


(defun enclose-insert (left)
  "Called when enclose key is hit."
  (if (enclose-pairing-p)
      (let ((right (gethash left enclose-table)))
        (enclose-insert-pair left right))
    (enclose-insert-fallback left)))

(defun enclose-insert-pair (left right)
  "Insert LEFT and RIGHT and place cursor between."
  (insert left right)
  (backward-char 1))

(defun enclose-insert-fallback (left)
  "Do not insert pair, fallback and call function LEFT was bound to
before `enclose-mode'."
  (enclose-fallback left))

(defun enclose-pairing-p ()
  "Checks if insertion should be a pair or not."
  (unless (region-active-p)
    (not (looking-at enclose-anti-regex))))

(defun enclose-remove ()
  "Called when user hits the delete key."
  (interactive)
  (if (enclose-remove-pairing-p)
      (enclose-remove-pair)
    (enclose-remove-fallback)))

(defun enclose-remove-pair ()
  "Removes pair surrounding cursor if match."
  (let ((before (char-before)) (after (char-after)))
    (unless (and before after)
      (return (enclose-remove-fallback)))
    (if (equal (gethash (char-to-string before) enclose-table) (char-to-string after))
        (delete-region (- (point) 1) (+ (point) 1))
      (enclose-remove-fallback))))

(defun enclose-remove-fallback ()
  "When enclose remove is not to be used."
  (enclose-fallback enclose-del-key))

(defun enclose-remove-pairing-p ()
  "Checks if removing should be on pair or not."
  (and
   enclose-remove-pair
   (not
    (looking-at (concat "." enclose-anti-regex)))))

(defun enclose-add-encloser (left right)
  "Add LEFT and RIGHT as an encloser pair."
  (puthash left right enclose-table)
  (enclose-define-trigger left))

(defun enclose-remove-encloser (left)
  "Remove LEFT as an encloser trigger."
  (remhash left enclose-table)
  (enclose-unset-key left))

(defun enclose-fallback (key)
  "Executes function that KEY was bound to before `enclose-mode'."
  (let ((enclose-mode nil))
    (call-interactively
     (key-binding
      (edmacro-parse-keys key)))))

(defun enclose-define-keys ()
  "Defines key bindings."
  (enclose-define-key enclose-del-key 'enclose-remove)
  (maphash
   (lambda (key _)
     (enclose-define-trigger key))
   enclose-table))

(defun enclose-define-trigger (key)
  "Defines KEY as trigger."
  (enclose-define-key
   key
   `(lambda ()
      (interactive)
      (enclose-insert ,key))))

(defun enclose-unset-key (key)
  "Remove KEY as an encloser trigger."
  (enclose-define-key key nil))

(defun enclose-define-key (key fn)
  "Binds KEY to FN in `enclose-mode-map'."
  (define-key enclose-mode-map (edmacro-parse-keys key) fn))


;;;###autoload
(define-minor-mode enclose-mode
  "Enclose cursor within punctuation pairs."
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
