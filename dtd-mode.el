;;; dtd-mode.el --- major mode for editing DTD files. -*- coding: utf-8; lexical-binding: t; mode: generic-mode -*-
;; Copyright © 2017, by Christopher R. Brown

;; Author: Christopher R. Brown ( mrlordvondoombraun@gmail.com )
;; Version: 0.0.2
;; Created: 26 OCT 2017
;; Keywords: major-mode,  
;; Homepage: teamawesome3.dlinkddns.com

;; <!-- Other general entities ............................................... -->
;;; License:

;;  This file is not part of GNU Emacs. This program is free software-
;;  you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.

;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;  This is a major-mode derived for writing DTD documents.

;;; Code:

(require 'highlight-numbers)

(defvar dtd-mode-hook nil
  "set dtd-mode hook.")

(defvar dtd-mode-font-lock-keywords ()
  "set element for font-lock-defaults.")

;;(defvar dtd-mode-syntax-table
;;  (let ((table (make-syntax-table)))
;;    (modify-syntax-entry ?< "<-- " table)
;;    (modify-syntax-entry ?> " -->" table)
;;    table)
;;  "Syntax table for dtd-mode")
			 
(setq dtd-mode-keywords
      '(
	"\<\!ELEMENT"
	"\<\!ATTLIST"
	"\<\!ENTITY"
	"\#PCDATA"
	"CDATA"
	"\#IMPLIED"
	"\#REQUIRED"
	"\#FIXED"
	"EMPTY"
	"ANY"
	"\<\!DOCTYPE"
	"\|"
	"\*"
	"\+"
	"\?"
	))

(defconst dtd-mode-font-lock-keywords
  `(
    ("<!DOCTYPE" . font-lock-function-name-face)
    ("<!ENTITY" . font-lock-keyword-face)
    ("<!ATTLIST" . font-lock-keyword-face)
    ("<!ELEMENT" . font-lock-keyword-face)
    ("\\(%\\)\\([a-zA-Z0-9\.]+\\)\\(;\\)" . font-lock-type-face)
    ("#PCDATA" . font-lock-variable-name-face)
    ("CDATA" . font-lock-variable-name-face)
    ("#IMPLIED" . font-lock-comment-face)
    ("#REQUIRED" . font-lock-comment-face)
    ("#FIXED" . font-lock-comment-face)
    ("EMPTY" . font-lock-variable-name-face)
    ("ANY" . font-lock-variable-name-face)
    ("IDREF" . font-lock-variable-name-face)
    ("\s(" . font-lock-keyword-face)
    (")" . font-lock-keyword-face)
    ("\\([+\\|?\\|*\\|%]\\)" . font-lock-keyword-face))
    "highlight those syntaxes.")

(defun dtd-mode-element-declaration ()
  "Insert '<!ELEMENT'"
  (interactive)
  (insert "<!ELEMENT "))

(defun dtd-mode-attribute-declaration ()
  "Insert '<!ATTLIST'"
  (interactive)
  (insert "<!ATTLIST "))

(defun dtd-mode-entity-declaration ()
  "Insert '<!ENTITY'"
  (interactive)
  (insert "<!ENTITY "))

(defun dtd-mode-pcdata-content ()
  "Insert '#PCDATA'"
  (interactive)
  (insert "#PCDATA"))

(defun dtd-mode-cdata-content ()
  "Insert 'CDATA'"
  (interactive)
  (insert "CDATA"))

(defun dtd-mode-required-att-value ()
  "Insert '#REQUIRED'"
  (interactive)
  (insert "#REQUIRED"))

(defun dtd-mode-implied-att-value ()
  "Insert '#IMPLIED'"
  (interactive)
  (insert "#IMPLIED"))

(defun dtd-mode-fixed-att-value ()
  "Insert '#FIXED'"
  (interactive)
  (insert "#FIXED"))

(defun dtd-mode-key-config ()
  "Keybinds for dtd-mode"
  (interactive)
  (local-set-key (kbd "C-c C-e") 'dtd-mode-element-declaration)
  (local-set-key (kbd "C-c C-a") 'dtd-mode-attribute-declaration)
  (local-set-key (kbd "C-c C-n") 'dtd-mode-entity-declaration)
  (local-set-key (kbd "C-c C-p") 'dtd-mode-pcdata-content)
  (local-set-key (kbd "C-c C-c") 'dtd-mode-cdata-content)
  (local-set-key (kbd "C-c C-r") 'dtd-mode-required-att-value)
  (local-set-key (kbd "C-c C-m") 'dtd-mode-implied-att-value)
  (local-set-key (kbd "C-c C-f") 'dtd-mode-fixed-att-value))

(defun dtd-mode-completion-at-point ()
  "Function for completing often used dtd keywords"
  (interactive)
  (let* (
         (bds (bounds-of-thing-at-point 'symbol))
         (start (car bds))
         (end (cdr bds)))
    (list start end dtd-mode-keywords . nil )))

(easy-menu-define dtd-mode-menu global-map
  "Menu for dtd-mode inserts"
  '("DTD"
    ["Element" dtd-mode-element-declaration]
    ["Attribute" dtd-mode-attribute-declaration]
    ["Entity" dtd-mode-entity-declaration]
    ["--" line]
    ["Fixed" dtd-mode-fixed-att-value]
    ["Implied" dtd-mode-implied-att-value]
    ["Required" dtd-mode-required-att-value]
    ))

;;;###autoload
  (defun dtd-mode ()
    "Major mode for editing DTD files"
    (interactive)
    (kill-all-local-variables)
    (setq mode-name "DTD Mode")
;;    (set-syntax-table dtd-mode-syntax-table)
    (set
     (make-local-variable 'font-lock-defaults)
     '(dtd-mode-font-lock-keywords))
    (add-to-list 'auto-mode-alist '("\\.dtd\\'" . dtd-mode))
    (add-hook 'dtd-mode-hook 'dtd-mode-key-config)
    (add-hook 'dtd-mode-hook 'dtd-mode-completion-at-point)
    (run-hooks 'dtd-mode-hook))
  
(provide 'dtd-mode)

;;; dtd-mode.el ends here
