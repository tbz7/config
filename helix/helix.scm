(require-builtin helix/core/keymaps)
(require "helix/commands.scm")
(require "helix/configuration.scm")
(require "helix/editor.scm")
(require "helix/static.scm")

(provide theme-from-env toggle-gutters-off toggle-gutters-on w!!)

;;@doc
;; Set the theme from $HELIX_THEME if valid.
(define (theme-from-env) (with-handler (λ (e) void) (theme (env-var "HELIX_THEME"))))

;;@doc
;; Hide the gutters.
(define (toggle-gutters-off)
  (set-option "gutters.layout" "[]")
  (add-global-keybinding (hash "normal" (hash "space" (hash "l" ":toggle-gutters-on")))))

;;@doc
;; Show the gutters.
(define (toggle-gutters-on)
  (set-option "gutters.layout" "[\"diagnostics\",\"spacer\",\"line-numbers\",\"spacer\",\"diff\"]")
  (add-global-keybinding (hash "normal" (hash "space" (hash "l" ":toggle-gutters-off")))))

;;@doc
;; Force write changes to disk using sudo.
(define (w!!)
  (save_selection)
  (select_all)
 ; TODO password input not working right
  (pipe-to "sudo" "tee" (editor-document->path (editor->doc-id (editor-focus))))
  (reload)
  (jump_backward))

(define (add-global-keybinding map)
  (define global-bindings (get-keybindings))
  (helix-merge-keybindings global-bindings (~> map (value->jsexpr-string) (helix-string->keymap)))
  (keybindings global-bindings))
