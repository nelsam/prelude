(load-theme 'wombat t)

(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(setq prelude-guru nil)

;; fullscreen shortcuts
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)

;; And set fullscreen on startup.  This will cause the -fs flag for
;; emacs to disable fullscreen, instead of the other way around.
(toggle-fullscreen)

;; Smaller fonts.
(set-face-attribute 'default nil :height 100)

;; This should make an indicator at 80 characters
;(require 'fill-column-indicator)
;(setq-default fci-rule-column 80)
;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode 1)

;; Set up "smart tabs" for languages which should use them.
(require 'smart-tab)
(global-smart-tab-mode 1)
(setq-default indent-tabs-mode nil)
(add-hook 'c-mode-hook
          (lambda () (setq indent-tabs-mode t)))

;; For Go development, add some Go-specific settings
(setq gofmt-command "goimports")
(require 'go-eldoc)
;(require 'auto-complete)
;(require 'go-autocomplete)
(require 'go-direx)
(require 'go-mode-autoloads)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'before-save-hook 'gofmt-before-save)

(require 'company)
(global-company-mode t)

(require 'whitespace)
(setq-default global-whitespace-mode t)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'revive)

(require 'smooth-scrolling)

;(setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
;(require 'tabbar-ruler)

(require 'zlc)

(require 'cedet)
(global-ede-mode 1)
(condition-case err
    (semantic-load-enable-code-helpers)
  ('error (semantic-mode)))
(condition-case err
    (global-srecode-minor-mode 1)
  ('error (srecode-template-mode)))

;; ECB tries to use stack-trace-on-error, which isn't in emacs 24
;; so set it.
(setq stack-trace-on-error t)
(setq ecb-version-check nil)
(setq ecb-auto-activate t)

(defadvice ecb-check-requirements (around no-version-check activate compile)
  "ECB version checking code is very old so that it thinks that the latest
cedet/emacs is not new enough when in fact it is years newer than the latest
version that it is aware of.  So simply bypass the version check."
  (if (or (< emacs-major-version 23)
          (and (= emacs-major-version 23)
               (< emacs-minor-version 3)))
      ad-do-it))

(require 'ecb)

;; C-x p defaults to opening a process list (effectively, the top
;; command).
;; emacs-for-python uses C-x p as a prefix for project commands,
;; so I needed to unbind it because ... well, I use the project
;; commands all the time, and I use the process list ... never.
(global-unset-key "\C-xp")
(local-unset-key "\C-xp")

;; Huge package, here.  emacs-for-python is a beautiful set of
;; libraries to make python development easier, faster, and more
;; enjoyable.  It includes everything from project commands
;; (find-file-in-project, open-project, etc) to refactoring commands
;; (C-c r r will open the refactor-rename dialog, letting you rename a
;; function or variable throughout the currently open project).
;; See https://github.com/gabrielelanaro/emacs-for-python/wiki for
;; details.
(add-to-list 'load-path "~/.emacs.d/emacs-for-python") ;; tell where to load the various files
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
(require 'epy-bindings)   ;; For my suggested keybindings [optional]
(require 'epy-nose)       ;; For nose integration

;; Make sure that python uses four spaces for indentation, as
;; recommended in PEP-8.
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq python-indent-offset 4)))
