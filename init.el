;; emacs.d/init.el
;; IDE for Python Development
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    ein
    jedi
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; NETWORK CONFIGURATION

;; If you need to set the proxy manually for some reason:
;;(setq url-proxy-services 
;;      '(("no_proxy" . "^\\(localhost\\|127\\.0\\.0\\.1\\|10\\..*\\|192\\.168\\..*\\)")
;;	("http" . "whatever:port") 
;;	("https" . "whatever:port")))

;; Terminal
(global-set-key (kbd "C-c d") 'eshell)

;; PYTHON
;; see:
;; * https://realpython.com/emacs-the-best-python-editor/
;; * https://elpy.readthedocs.io/en/latest/ide.html#interpreter-setup
(elpy-enable)
(setq elpy-rpc-backend "jedi")
(add-to-list 'elpy-modules 'elpy-module-autodoc)

;; Use jupyter as our interactive interpreter
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;(setq python-shell-interpreter "ipython"
;      python-shell-interpreter-args "-i --simple-prompt")

; or

;(setq python-shell-interpreter "python"
;      python-shell-interpreter-args "-i")

;; Swap syntax checking (default flymake) for flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
