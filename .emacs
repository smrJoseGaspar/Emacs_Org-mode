;; Python Source Code Blocks in Org Mode
;; https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-python.html
(require 'ob-python)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Si tu sistema solo tiene python3 (muy común en GNU/Linux modernos), indica a Org que use ese binario para
;; ejecutar los bloques python
(setq org-babel-python-command "python3")

;; Modo Vertico

;; (require 'use-package)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(marginalia orderless vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring




