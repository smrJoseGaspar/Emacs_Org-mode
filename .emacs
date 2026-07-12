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

;; Emacs-reader
;; El paquete **`emacs-reader`** (a veces visto como “Emacs Reader”) es un visor/lector de documentos para GNU Emacs
;; funciona como un **sustituto** de herramientas como `doc-view`, `nov.el` y `pdf-tools`. Abre **formatos de documentos comunes** usando **MuPDF** y te permite navegar por páginas con atajos de teclado.
;; --- Comento porque ha generado un ERROR al cargar ----
;;(use-package reader
;;  :vc (:url "https://codeberg.org/MonadicSheep/emacs-reader"
;;       :make "all")
;;  :mode (("\\.pdf\\'"  . reader-mode)
;;         ("\\.epub\\'" . reader-mode)
;;         ("\\.mobi\\'" . reader-mode)
;;         ("\\.cbz\\'"  . reader-mode))
;;  :hook (reader-mode . (lambda ()
;;                         (display-line-numbers-mode 0)
;;                         (set-fringe-mode 0)
;;                         (let ((margin (max 0 (/ (- (window-total-width) 100) 2))))
;;                           (set-window-margins (selected-window) margin margin)))))
;; --- Fin comentario ERROR al cargar ---

;; Magit
;; `magit` en Emacs es un paquete que te da una **interfaz (UI) tipo “Git porcelain”) para Git**: desde Emacs puedes ver el estado del repositorio, preparar/cambiar cambios (staging/unstaging),
;; hacer commits, gestionar ramas, y operaciones como pull/push, merges, rebases, etc., ejecutando comandos de Git por detrás.

(use-package magit)

(use-package forge
  :after magit)

(use-package magit-todos
  :after magit
  :config
  (setq magit-todos-branch-list nil)
  (magit-todos-mode))

;; projectile
;; `projectile` en Emacs es un paquete de **gestión y navegación por proyectos**: detecta la carpeta raíz del proyecto y te permite hacer cosas “a nivel de proyecto”
;; como buscar/abrir archivos, saltar entre buffers/archivos relacionados (p. ej. código ↔ tests), y ejecutar comandos típicos como build/test/run.

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (setq projectile-project-search-path '("~/dev" "~/projects"))
  (setq projectile-switch-project-action #'projectile-dired))

;; Treemacs
;; `treemacs` en Emacs es un paquete que muestra un **panel lateral con un árbol** de archivos/carpetas para navegar tu proyecto y abrir archivos desde una vista jerárquica.

(use-package treemacs
  :defer t
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          t
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                0.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)
    (treemacs-resize-icons 15)
    (treemacs-project-follow-mode t)
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)))

  (use-package treemacs-evil
    :after (treemacs evil))

  (use-package treemacs-projectile
    :after (treemacs projectile))

  (use-package treemacs-magit
    :after (treemacs magit))
 


;; Markdown preview en Emacs (Emacs 30.2)
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)))

;; Desactivamos markdown-preview-mode para evitar ERRORES.
;;(use-package markdown-preview-mode
;;  :ensure t
;;  :after markdown-mode
;;  :commands markdown-preview-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/setup/html-theme-bigblow\\.setup\\'"))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((reader :url "https://codeberg.org/MonadicSheep/emacs-reader" :make
	     "all"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
