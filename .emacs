(add-to-list 'load-path "/home/lesbroot/.emacs.d/")

;package.el
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;lisp
(setq inferior-lisp-program "/usr/bin/clisp")

;slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))
	  ;(defun paredit-mode-enable () (paredit-mode 1))
	  ;(add-hook 'slime-mode-hook 'paredit-mode-enable)
	  ;(add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
	  (setq slime-protocol-version 'ignore)))
(add-to-list 'load-path "/home/lesbroot/Build/slime")
(require 'slime)
;(setq slime-net-coding-system 'utf-8-unix)
(slime-setup)

;geiser for scheme
(load "/home/lesbroot/.emacs.d/geiser/build/elisp/geiser-load.el")
(require 'geiser-install)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(geiser-mode-smart-tab-p t)
 '(geiser-racket-binary "/usr/bin/racket")
 '(geiser-racket-collects (quote ("/usr/lib/racket/collects/")))
 '(inhibit-startup-screen t))
(setq geiser-impl-installed-implementations '(racket guile))
(setq geiser-active-implementations '(racket))
(setq geiser-repl-history-filename "/home/lesbroot/.emacs.d/geiser-history")

;set theme
(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

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

;paredit
(add-to-list 'load-path "/usr/share/emacs/site-lisp/paredit.el")
(autoload 'paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(require 'paredit)

;general
(setq line-number-mode t)
(setq column-number-mode t)
(tool-bar-mode -1) ;disable toolbar
(toggle-scroll-bar -1)
(global-linum-mode t)

;line break
(setq-default fill-column 79)
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;for terminal mode
(xterm-mouse-mode 1)

;clojure
(add-to-list 'load-path "/home/lesbroot/Build/clojure-mode")
(require 'clojure-mode)

;c/c++
(setq-default c-basic-offset 4)
(setq-default c-basic-indent 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(require 'blank-mode)

;arduino
(require 'arduino-mode)

;erlang


(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.8/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)

(add-to-list 'load-path "/home/lesbroot/.emacs.d/distel/elisp")
(require 'distel)
(distel-setup)
;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
          (lambda ()
	    ;; add some Distel bindings to the Erlang shell
            (dolist (spec distel-shell-keys)
              (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(add-hook 'erlang-mode-hook
      (lambda ()
        ;; when starting an Erlang shell in Emacs, with the node
        ;; short name set to renzhi
        (setq inferior-erlang-machine-options '("-sname" "lr"))
        ;; add Erlang functions to an imenu menu
        (imenu-add-to-menubar "imenu")))


;minimap
(require 'minimap)

;fluxus
(require 'fluxus-mode)

;prolog

(setq load-path (cons "/usr/local/sicstus4.2.1/lib/sicstus-4.2.1/emacs" load-path))
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(setq prolog-use-sicstus-sd t)
(setq auto-mode-alist (cons '("\\.pl$" . prolog-mode) auto-mode-alist))

;python
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)
            (setq python-indent 4)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
