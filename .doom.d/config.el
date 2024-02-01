(after! lsp-mode
  (setq lsp-auto-guess-root t)  ; Automatically detect the project root.
  (setq lsp-clients-typescript-server "typescript-language-server"
        lsp-clients-typescript-server-args '("--stdio")))


(map! :leader
      :desc "LSP Format Buffer"
      "l f" #'lsp-format-buffer)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

(use-package! doom-modeline
  :config
  (setq doom-modeline-persp-name t))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `USE-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Vlad Terin"
      user-mail-address "vladterin@gmail.com")

;; Turn on pixel scrolling
(pixel-scroll-precision-mode t)

;; Turn on abbrev mode
(setq-default abbrev-mode t)

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))



;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; compiler warnings as they can be pretty disruptive
(setq comp-async-report-warnings-errors nil)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(map! :leader
      :desc "Treemacs - Find File" "e" #'treemacs-find-file)
(map! :n "s-q" #'evil-switch-to-windows-last-buffer)
(map! :leader
      "d" #'gptel)
(map! :leader
      :desc "Search directory with consult-dir"
      "s d" #'consult-dir)
(map! "s-}" #'hs-show-all)
(map! "s-{" #'hs-hide-all)
(map! "s-]" #'hs-show-block)
(map! "s-[" #'hs-hide-block)




(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(defun open-custom-agenda ()
  (interactive)
  (org-agenda nil "n")) ; "n" is the shortcut for the custom agenda command in the org-agenda dispatcher

(add-hook 'emacs-startup-hook 'open-custom-agenda)

(use-package! gptel :config
              (setq! gptel-api-key "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"))
;; :key can be a function that returns the API key.
(gptel-make-gemini
 "Gemini"
 :key "AIzaSyABcgb5JReFLtl6cewz2leHX28IECvaJ_I"
 :stream t)
(add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)
(add-hook 'gptel-post-response-hook 'gptel-end-of-response)

(setq split-height-threshold nil
      split-width-threshold 0)


(after! lsp-clients
  (setq lsp-clients-typescript-server-args '("--stdio"))
  (add-to-list 'exec-path "/Users/vlad/.nvm/versions/node/v18.16.0/bin"))

(setq exec-path (append exec-path '("/Users/vlad/.nvm/versions/node/v18.16.0/bin")))


(use-package! skewer-mode
  :hook (js2-mode . skewer-mode)
  :config
  (skewer-setup))


(require 'c3po)
(setq c3po-api-key "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")

(use-package! multi-vterm
  :config
  (add-hook 'vterm-mode-hook
	    (lambda ()
	      (setq-local evil-insert-state-cursor 'box)
	      (evil-insert-state)))
  (define-key vterm-mode-map [return]                      #'vterm-send-return)

  (setq vterm-keymap-exceptions nil)
  (evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "C-n")       #'multi-vterm)
  (evil-define-key 'normal vterm-mode-map (kbd "C-j")       #'multi-vterm-next)
  (evil-define-key 'normal vterm-mode-map (kbd "C-k")       #'multi-vterm-prev)
  (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))

(after! vterm
  (define-key vterm-mode-map (kbd "C-k") nil))




;; Set the path to the mermaid.cli executable
(setq ob-mermaid-cli-path (executable-find "mmdc"))

;; Ensure Org Babel supports mermaid
(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t)
     (scheme . t)
     (python . t))))

(defun my/vterm-evil-delete-line ()
  "Custom command to delete the current input line in vterm."
  (interactive)
  (vterm-send-key "u" nil nil t))  ; This sends Ctrl-U to the terminal to delete the line.

(with-eval-after-load 'vterm
  (evil-define-key 'normal vterm-mode-map
    "dd" 'my/vterm-evil-delete-line))

(add-hook 'prog-mode-hook #'hs-minor-mode)



(defun toggle-hiding-classname (start end)
  "Toggle hiding/showing of a block if it contains a className."
  (save-excursion
    (goto-char start)
    (if (and (hs-already-hidden-p)
             (re-search-forward "className=" end t))
        (hs-hide-all)
      (hs-show-all))))

(defun fold-all-classname ()
  "Fold all blocks that contain a className."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "className=" nil t)
      (let ((start (line-beginning-position))
            (end (line-end-position)))
        (toggle-hiding-classname start end)))))

(defun my-jsx-mode-setup ()
  "Custom JSX mode setup for hiding className blocks."
  (hs-minor-mode 1)
  (fold-all-classname)
  (add-hook 'post-command-hook 'hs-show-block-temporarily nil t))

(defun hs-show-block-temporarily ()
  "Unfold the current block temporarily when the point is inside a hidden block."
  (interactive)
  (when (hs-already-hidden-p)
    (hs-show-block)))

(add-hook 'web-mode-hook 'my-jsx-mode-setup)

(after! web-mode
  (web-mode-set-engine "django")
  (define-key web-mode-map (kbd "C-SPC") 'emmet-expand-line))



(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored "/opt/homebrew"))

(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src" nil nil)
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))


(use-package cape
  :after (lsp-mode codeium)
  :init
  ;; Prioritize codeium completions and include LSP
  (add-hook 'typescript-tsx-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list (cape-super-capf #'codeium-completion-at-point))))))

;; we recommend using use-package to organize your init.el
(use-package codeium
  ;; if you use straight
  ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
  ;; otherwise, make sure that the codeium.el file is on load-path

  :init
  ;; use globally
  (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
  ;; or on a hook
  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

  ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
  (add-hook 'typescript-tsx-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (setq-local completion-at-point-functions
                                      (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point))))))

  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local completion-at-point-functions
  ;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
  ;; an async company-backend is coming soon!

  ;; codeium-completion-at-point is autoloaded, but you can
  ;; optionally set a timer, which might speed up things as the
  ;; codeium local language server takes ~0.2s to start up
  ;; (add-hook 'emacs-startup-hook
  ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

  ;; :defer t ;; lazy loading, if you want
  :config
  (setq use-dialog-box nil) ;; do not use popup boxes

  ;; if you don't want to use customize to save the api-key
  ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

  ;; get codeium status in the modeline
  (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
  (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
  ;; alternatively for a more extensive mode-line
  ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

  ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
  (setq codeium-api-enabled
        (lambda (api)
          (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
  ;; you can also set a config for a single buffer like this:
  ;; (add-hook 'python-mode-hook
  ;;     (lambda ()
  ;;         (setq-local codeium/editor_options/tab_size 4)))

  ;; You can overwrite all the codeium configs!
  ;; for example, we recommend limiting the string sent to codeium for better performance
  (defun my-codeium/document/text ()
    (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
  ;; if you change the text, you should also change the cursor_offset
  ;; warning: this is measured by UTF-8 encoded bytes
  (defun my-codeium/document/cursor_offset ()
    (codeium-utf8-byte-length
     (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
  (setq codeium/document/text 'my-codeium/document/text)
  (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))

(use-package company
  :defer 0.1
  :config
  (global-company-mode t)
  (setq-default
   company-idle-delay 0.05
   company-require-match nil
   company-minimum-prefix-length 0
   ;; Set up the company frontends you want to use
   company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend company-echo-metadata-frontend)
   ;; Define the backends for code completion
   company-backends '(company-capf)
   )
  (yas-global-mode -1)
  )


(defun toggle-lsp-connection ()
  "Toggle LSP connection."
  (interactive)
  (if (and (boundp 'lsp-mode) lsp-mode)
      (progn
        (lsp-disconnect)
        (message "Disconnected from LSP server."))
    (progn
      (lsp)
      (message "Connected to LSP server."))))

(after! lsp-mode
  ;; Map the toggle function to 'C-c l t'
  (map! :leader
        :desc "Toggle LSP connection"
        "l t" #'toggle-lsp-connection))


(defun toggle-lsp ()
  "Toggle LSP completion."
  (interactive)
  (if (memq 'company-capf company-backends)
      (setq company-backends (remove 'company-capf company-backends))
    (add-to-list 'company-backends 'company-capf)))

(map! :leader
      :desc "Toggle yasnippet completion"
      "t y" #'toggle-yasnippet)

(map! :leader
      :desc "Toggle LSP completion"
      "t l" #'toggle-lsp)


(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(astro-mode . "astro"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                    :activation-fn (lsp-activate-on "astro")
                    :server-id 'astro-ls)))

(setq yas-snippet-dirs '("~/.doom.d/snippets"))
