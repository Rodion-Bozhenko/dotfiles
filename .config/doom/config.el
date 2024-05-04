;; mmmmmm  mmmm  mm   mmmmmmmm  mmmm
;; #      m"  "m #"m  #   #    #"   "
;; #mmmmm #    # # #m #   #    "#mmm
;; #      #    # #  # #   #        "#
;; #       #mm#  #   ##   #    "mmm#"

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font Mono" :size 19))



;; mmmmmmm m    m mmmmmm m    m mmmmmm  mmmm
;;    #    #    # #      ##  ## #      #"   "
;;    #    #mmmm# #mmmmm # ## # #mmmmm "#mmm
;;    #    #    # #      # "" # #          "#
;;    #    #    # #mmmmm #    # #mmmmm "mmm#"

(setq doom-theme 'doom-nord)
(add-to-list 'custom-theme-load-path "~/.doom.d/themes")



;;  mmmm  mmmmm mmmmmmm mmmmm   mmmm  mm   m  mmmm
;; m"  "m #   "#   #      #    m"  "m #"m  # #"   "
;; #    # #mmm#"   #      #    #    # # #m # "#mmm
;; #    # #        #      #    #    # #  # #     "#
;;  #mm#  #        #    mm#mm   #mm#  #   ## "mmm#"

(setq display-line-numbers-type 'relative
      scroll-margin 8)

(defun my/evil-change-advice (orig-fn beg end type register &rest args)
  "Advice to change text using the black hole register."
  (apply orig-fn beg end type ?_ args))

(defun my/evil-change-line-advice (orig-fn beg end type register &rest args)
  "Advice to change entire line text using the black hole register."
  (apply orig-fn beg end type ?_ args))
(after! evil
  (advice-add 'evil-change :around #'my/evil-change-advice)
  (advice-add 'evil-change-line :around #'my/evil-change-line-advice))



;;  mmmm  mmmmm    mmm
;; m"  "m #   "# m"   "
;; #    # #mmmm" #   mm
;; #    # #   "m #    #
;;  #mm#  #    "  "mmm"

(setq org-directory "~/org/")



;; mmmmm  m      m    m   mmm  mmmmm  mm   m  mmmm
;; #   "# #      #    # m"   "   #    #"m  # #"   "
;; #mmm#" #      #    # #   mm   #    # #m # "#mmm
;; #      #      #    # #    #   #    #  # #     "#
;; #      #mmmmm "mmmm"  "mmm" mm#mm  #   ## "mmm#"

(setq projectile-project-search-path '("~/work/" "~/personal/"))

(use-package avy
  :commands (avy-goto-char avy-goto-word-1 avy-goto-line)
  :config
  (setq
   avy-background t
   avy-all-windows t
   ))



;; m    m mmmmmmm     m m    m   mm   mmmmm   mmmm
;; #  m"  #      "m m"  ##  ##   ##   #   "# #"   "
;; #m#    #mmmmm  "#"   # ## #  #  #  #mmm#" "#mmm
;; #  #m  #        #    # "" #  #mm#  #          "#
;; #   "m #mmmmm   #    #    # #    # #      "mmm#"

;; Map Ctrl+d to scroll down half a page and recenter
(map! :n "C-d" (lambda () (interactive)
                 (evil-scroll-down nil)
                 (recenter)))

;; Map Ctrl+u to scroll up half a page and recenter
(map! :n "C-u" (lambda () (interactive)
                 (evil-scroll-up nil)
                 (recenter)))

;; AVY
(map! :leader
      :desc "Avy go to char" "s c" #'avy-goto-char
      :desc "Avy go to word" "s w" #'avy-goto-word-1
      :desc "Avy go to line" "s l" #'avy-goto-line)



;; m       mmmm  mmmmm
;; #      #"   " #   "#
;; #      "#mmm  #mmm#"
;; #          "# #
;; #mmmmm "mmm#" #

(use-package lsp-ui)

(defun my/toggle-lsp-ui-doc-focus ()
  "Toggle lsp-ui-doc and focus if already open."
  (interactive)
  (if (lsp-ui-doc--frame-visible-p)
      (lsp-ui-doc-focus-frame)
    (lsp-ui-doc-show)))

(after! lsp-ui
  (setq lsp-ui-doc-enable nil
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-max-width 150
        lsp-ui-doc-max-height 50
        lsp-ui-doc-delay 0
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse nil)

  (custom-set-faces
   '(markdown-code-face ((t (:background nil)))))

  (map! :map general-override-mode-map
        "K" nil)

  (map! :mode lsp-mode
        :n "K" #'my/toggle-lsp-ui-doc-focus))


(setq lsp-log-io nil) ; if set to true can cause a performance hit

(setq lsp-inlay-hint-enable t)


;; m    m  mmmm  mmmm   mmmmmm m      mmmmm  mm   m mmmmmm
;; ##  ## m"  "m #   "m #      #        #    #"m  # #
;; # ## # #    # #    # #mmmmm #        #    # #m # #mmmmm
;; # "" # #    # #    # #      #        #    #  # # #
;; #    #  #mm#  #mmm"  #mmmmm #mmmmm mm#mm  #   ## #mmmmm

(setq doom-modeline-column-zero-based t
      doom-modeline-position-column-line-format '("%l:%c")
      doom-modeline-enable-word-count nil
      doom-modeline-lsp t
      doom-modeline-always-show-macro-register nil
      doom-modeline-env-version t
      doom-modeline-height 60
      doom-modeline-percent-position '(-3 "%p")
      doom-modeline-lsp-icon t
      doom-modeline-time-live-icon t)

(custom-set-faces
 '(mode-line ((t (:family "Nerd Font Mono" :height 160))))
 '(mode-line-active ((t (:family "Nerd Font Mono" :height 160))))
 '(mode-line-inactive ((t (:family "Nerd Font Mono" :height 160)))))



;;  mmmm  mmmmm    mmm  m    m  mmmm  mmmm   mmmmmm
;; m"  "m #   "# m"   " ##  ## m"  "m #   "m #
;; #    # #mmmm" #   mm # ## # #    # #    # #mmmmm
;; #    # #   "m #    # # "" # #    # #    # #
;;  #mm#  #    "  "mmm" #    #  #mm#  #mmm"  #mmmmm

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "●" "○" "◆" "●" "○" "◆")))

