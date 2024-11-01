(require-builtin helix/core/configuration)
(require-builtin helix/core/editor)
(require-builtin helix/core/keymaps)
(require-builtin helix/core/static)
(require-builtin helix/core/typable)

(provide theme-from-env toggle-gutters-off toggle-gutters-on w!!)

;;@doc
;; Set the theme from $HELIX_THEME if valid.
(define (theme-from-env)
  (with-handler (λ (e) void) (theme *helix.cx* (list (env-var "HELIX_THEME")))))

;;@doc
;; Hide the gutters.
(define (toggle-gutters-off)
  (set-option *helix.cx* '("gutters.layout" "[]"))
  (add-global-keybinding (hash "normal" (hash "space" (hash "l" ":toggle-gutters-on")))))

;;@doc
;; Show the gutters.
(define (toggle-gutters-on)
  (set-option
    *helix.cx*
    '("gutters.layout" "[\"diagnostics\",\"spacer\",\"line-numbers\",\"spacer\",\"diff\"]"))
  (add-global-keybinding (hash "normal" (hash "space" (hash "l" ":toggle-gutters-off")))))

;;@doc
;; Force write changes to disk using sudo.
(define (w!!)
  (save_selection *helix.cx*)
  (select_all *helix.cx*)
  ; TODO password input not working right
  (pipe-to *helix.cx* (list "sudo" "tee" (current-path)))
  (reload *helix.cx* `())
  (jump_backward *helix.cx*))

(define (add-global-keybinding map)
  (define global-bindings (get-keybindings *helix.config*))
  (helix-merge-keybindings global-bindings (~> map (value->jsexpr-string) (helix-string->keymap)))
  (keybindings *helix.config* global-bindings))

(define (current-path)
  (editor-document->path *helix.cx* (editor->doc-id *helix.cx* (editor-focus *helix.cx*))))
