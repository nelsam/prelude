;; Designed to be symlinked to any $GOPATH/.dir-locals.el.  Sets
;; GOPATH to the directory that contains this file (or symlink).

((go-mode . (
             (eval . (make-local-variable 'process-environment))
             (eval . (make-local-variable 'exec-path))
             (eval . (setq project-gopath (replace-regexp-in-string "~" (getenv "HOME") (locate-dominating-file buffer-file-name ".dir-locals.el"))))
             (eval . (setq project-gobin (concatenate 'string project-gopath "bin")))
             (eval . (setenv "GOPATH"
                     (concat
                      (getenv "GOPATH") ":"
                      project-gopath
                      )))
             (eval . (setq exec-path
                           (append exec-path `(,project-gobin))))
             )))
