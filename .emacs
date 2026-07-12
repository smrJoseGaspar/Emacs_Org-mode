;; Python Source Code Blocks in Org Mode
;; https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-python.html
(require 'ob-python)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Si tu sistema solo tiene python3 (muy común en GNU/Linux modernos), indica a Org que use ese binario para
;; ejecutar los bloques python
(setq org-babel-python-command "python3")

;; Copia pega Configuracion Emacs
;; URL: https://github.com/migueldeoleiros/emacs-conf/blob/master/emacsConf.org
;; Minibuffer completion
;; Vertico and friends

;; Vertico
;; En Emacs, **Vertico** es un **paquete** que te da una **interfaz vertical para autocompletado en el minibúfer** (por ejemplo al usar `M-x`, buscar buffers, abrir archivos, etc.).

(use-package vertico
  :custom
  (vertico-count 13)
  (vertico-cycle nil)
  (vertico-resize t)
  :config
  (vertico-mode))

;; En Emacs, `savehist` (normalmente como `savehist-mode`) es un paquete/modo que **guarda el historial del minibúfer** entre sesiones.
;; Así, cuando vuelvas a usar `M-x` u otros comandos que piden texto en el minibúfer, Emacs puede mostrarte entradas anteriores y navegar ese historial (por ejemplo con `M-n`/`M-p`).

(use-package savehist
  :ensure nil
  :init
  (savehist-mode))

;; En Emacs, `recentf` (normalmente activando `recentf-mode`) es una función/paquete que **mantiene una lista de los archivos usados recientemente**
;; para que puedas **volver a abrirlos rápido** desde el menú **“Open Recent”** o con comandos como `M-x recentf-open`. La lista **se guarda entre sesiones**.

(use-package recentf
  :ensure nil
  :config
  (recentf-mode))

;; `orderless` en Emacs es un **estilo de autocompletado** (paquete) que hace que las coincidencias sean **“en cualquier orden”**:
;; divides lo que escribes en partes (por defecto por espacios) y un candidato debe **contener todas las partes**, aunque estén en distinto orden.
;; Además, cada parte puede matchearse como texto literal o como regexp (y se puede configurar para otros modos).

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; En Emacs, `marginalia` es un paquete que **añade anotaciones (“metadatos”) a las opciones del autocompletado en el minibúfer**.
;; Por ejemplo, al completar `find-file` puede mostrar información útil de archivos, y al usar `M-x` puede anotar comandos; estas marcas ayudan a distinguir candidatos sin cambiar el texto base de cada opción.

(use-package marginalia
  :bind (:map minibuffer-local-map
         ("C-<right>" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after (marginalia nerd-icons)
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :init
  (nerd-icons-completion-mode))

;; `consult` en Emacs es un paquete que añade **comandos de búsqueda y navegación** usando la función estándar de Emacs `completing-read`,
;; generalmente con resultados interactivos (incluyendo búsquedas como `consult-line`, `consult-grep`/`consult-ripgrep`, y cambio avanzado de buffers con `consult-buffer`).

(use-package consult
  :init
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)))

(use-package consult-projectile)

(use-package consult-dir
  :bind (("C-x C-d" . consult-dir)
         :map minibuffer-local-completion-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

;; ---- Fin copia pega: Vertico and friends ----

;; ---- Confifuraciones antenriores

;; Modo Vertico

;; (require 'use-package)

;; (use-package vertico
;;  :ensure t
;;  :init
;;  (vertico-mode))

;; (use-package marginalia
;;  :ensure t
;;  :init
;;  (marginalia-mode))


;; Markdown preview en Emacs (Emacs 30.2)
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)))

;; Desactivamos markdown-preview-mode para evitar ERRORES.
;;(use-package markdown-preview-mode
;;  :ensure t
;;  :after markdown-mode
;;  :commands markdown-preview-mode)


