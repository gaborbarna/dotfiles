(add-to-list 'load-path "/home/lesbroot/.emacs.d/elpa")

;package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;set theme
(load-theme 'solarized-dark t)

(setq processing-location "/usr/bin/processing-java")
;(setq processing-application-dir "/Applications/Processing.app")
;(setq processing-sketchbook-dir "~/Documents/Processing")

;font size
(set-face-attribute 'default nil :height 80)

;key bindings
(global-set-key (kbd "M-<up>") 'beginning-of-buffer)
(global-set-key (kbd "M-<down>") 'end-of-buffer)
(global-set-key (kbd "<f5>") 'compile)
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
(line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key (kbd "\C-c\C-v") 'copy-line)

(defun newline-below ()
  (interactive)
  (move-end-of-line nil)
  (newline))
(global-set-key (kbd "\C-o") 'newline-below)

(define-key global-map (kbd "RET") 'newline-and-indent)

;hilight parenthesis
(show-paren-mode 1)
(setq show-paren-style 'parenthesis) ; highlight just parens

;general
(setq line-number-mode t)
(setq column-number-mode t)
(tool-bar-mode -1) ;disable toolbar
(toggle-scroll-bar -1)
(global-linum-mode t)

;line break
(setq-default fill-column 79)
(setq default-major-mode 'text-mode)
;(add-hook 'text-mode-hook 'turn-on-auto-fill)

(ido-mode 1)

(add-hook 'ruby-mode-hook 'robe-mode)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "<%" "%>"))

(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)
