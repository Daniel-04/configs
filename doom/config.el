;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq display-line-numbers-type t)
(setq org-directory "~/Documents/org/")

(setq doom-theme 'adwaita)
(custom-set-faces!
  '(hl-line :background "#ffffcc")
  '(region :background "#ffffcc")
  '(whitespace-tab :inherit default)
  '(font-lock-variable-name-face :foreground "dark blue")
  '(font-lock-escape-face :foreground "#4e9a06")
  '(font-lock-variable-use-face :inherit default)
  '(font-lock-type-face :foreground nil :weight bold :inherit default)
  '(font-lock-keyword-face :foreground nil :weight bold :inherit default)
  '(font-lock-comment-face :inherit default :background "yellow")
  '(font-lock-constant-face :foreground nil :weight bold :inherit default))

(defun diablo-hellfire ()
  (let* ((banner '("▓█████▄  ██▓ ▄▄▄       ▄▄▄▄    ██▓     ▒█████  "
                   "▒██▀ ██▌▓██▒▒████▄    ▓█████▄ ▓██▒    ▒██▒  ██▒"
                   "░██   █▌▒██▒▒██  ▀█▄  ▒██▒ ▄██▒██░    ▒██░  ██▒"
                   "░▓█▄   ▌░██░░██▄▄▄▄██ ▒██░█▀  ▒██░    ▒██   ██░"
                   "░▒████▓ ░██░ ▓█   ▓██▒░▓█  ▀█▓░██████▒░ ████▓▒░"
                   " ▒▒▓  ▒ ░▓   ▒▒   ▓▒█░░▒▓███▀▒░ ▒░▓  ░░ ▒░▒░▒░ "
                   " ░ ▒  ▒  ▒ ░  ▒   ▒▒ ░▒░▒   ░ ░ ░ ▒  ░  ░ ▒ ▒░ "
                   " ░ ░  ░  ▒ ░  ░   ▒    ░    ░   ░ ░   ░ ░ ░ ▒  "
                   "   ░     ░        ░  ░ ░          ░  ░    ░ ░  "
                   " ░                 E M A C S░                  "
                   " ▄  █ ▄███▄   █    █    ▄████  ▄█ █▄▄▄▄ ▄███▄  "
                   "█   █ █▀   ▀  █    █    █▀   ▀ ██ █  ▄▀ █▀   ▀ "
                   "██▀▀█ ██▄▄    █    █    █▀▀    ██ █▀▀▌  ██▄▄   "
                   "█   █ █▄   ▄▀ ███▄ ███▄ █      ▐█ █  █  █▄   ▄▀"
                   "   █  ▀███▀       ▀    ▀ █      ▐   █   ▀███▀  "
                   "  ▀                       ▀        ▀           "
                   ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'diablo-hellfire)

(load! "cuneiform.el")

(use-package! typst-mode)

(add-hook 'bqn-mode-hook
          (lambda () (local-set-key (kbd "C-c C-d") #'bqn-help-symbol-info-at-point)))
(defun run-bqn-and-display-output ()
  (interactive)
  (message "%s" (shell-command-to-string (format "bqn -f %s" (buffer-name)))))
(add-hook 'bqn-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'run-bqn-and-display-output)))
(add-hook 'gnu-apl-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'gnu-apl-interactive-send-buffer)))

(defun bear ()
  (interactive)
  (shell-command "bear -- make"))
(defun make ()
  (interactive)
  (shell-command "make"))
(defun make-debug ()
  (interactive)
  (shell-command "make debug"))

(after! quickrun
  (quickrun-add-command "scheme/guile"
    '((:command . "guile")
      (:exec    . ("%c %s"))
      (:description . "Run Scheme code with Guile"))
    :default "scheme")
  (quickrun-add-command "haskell/ghc"
    '((:command . "runghc")
      (:exec    . ("%c %s"))
      (:description . "Run Haskell code with runghc"))
    :default "haskell"))
(map! :leader
      "r" #'quickrun)

(after! gdb-mi
  (setq gdb-many-windows t))

(use-package! disaster
  :commands (disaster)
  :init
  (map! :localleader
        :map (c++-mode-map c-mode-map fortran-mode-map)
        :desc "Disaster" "d" #'disaster))
