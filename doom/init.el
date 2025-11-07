;;; init.el -*- lexical-binding: t; -*-
(doom! :input
       :completion
       (corfu +icons +orderless)  ; complete with cap(f), cape and a flying feather!
       (ivy +prescient +fuzzy +icons)               ; a search engine for love and life
       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       (emoji +ascii +github +unicode) ; 🙂
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides     ; highlighted indent columns
       (ligatures +extra +fira +hasklig +iosevka +pragmata-pro)
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       unicode           ; extended unicode support for various languages
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       workspaces        ; tab emulation, persistence & separate workspaces
       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave +lsp)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to
       (whitespace +guess +trim)  ; a butler for your whitespace
       word-wrap         ; soft wrapping with language-aware indent
       :emacs
       (dired +dirvish +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       tramp             ; remote files at your arthritic fingertips
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree
       :term
       eshell            ; the elisp shell that works everywhere
       vterm             ; the best terminal emulation in Emacs
       :checkers
       (syntax +childframe)              ; tasing you for every semicolon you forget
       (spell +flyspell) ; tasing you for misspelling mispelling
       :tools
       debugger          ; FIXME stepping through code, to help you add bugs
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       ;;llm               ; when I said you needed friends, I didn't mean...
       (lsp +eglot)      ; M-x vscode
       magit             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       pdf               ; pdf enhancements
       tree-sitter       ; syntax and parsing, sitting in a tree...
       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       tty               ; improve the terminal Emacs experience
       :lang
       (cc +lsp +tree-sitter)         ; C > C++ == 1
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (haskell +lsp)    ; a language that's lazier than I am
       (json +lsp +tree-sitter)              ; At least it ain't XML
       (lua +lsp)               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       (ocaml +lsp)             ; an objective camel
       (org +gnuplot +dragndrop +pretty)               ; organize your plain life in plain text
       graphviz          ; diagrams for confusing yourself even more
       (python +lsp +pyright +cython)            ; beautiful is better than ugly
       (rust +lsp +tree-sitter)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (scheme +guile)   ; a fully conniving family of lisps
       (sh +lsp +tree-sitter)                ; she sells {ba,z,fi}sh shells on the C xor
       (web +lsp +tree-sitter)
       yaml              ; JSON, but readable
       :email
       :app
       :config
       (default +bindings +smartparens))
