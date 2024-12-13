set notimeout
set virtualedit=onemore
set whichwrap=h,l,<,>,[,]

let g:hxs = 0

fun! HelixCmdNotImplemented(command)
  echo 'Helix command not implemented: ' .. a:command
  return ''
endfun

"=== Movement ===

nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
xnoremap <expr> <Up> 'gk' .. (g:hxs ? '' : "\<Esc>")
xnoremap <expr> <Down> 'gj' .. (g:hxs ? '' : "\<Esc>")
xnoremap <expr> <Left> 'h' .. (g:hxs ? '' : "\<Esc>")
xnoremap <expr> <Right> 'l' .. (g:hxs ? '' : "\<Esc>")

map k <Up>
map j <Down>
xmap h <Left>
xmap l <Right>

" diff: some issues with whitespace and newlines, w/W get stuck at EOL in ideavim
nnoremap <silent> b :let g:hxs=0<Enter>m`hviwo``<Esc>`<vlb
nnoremap <silent> B :let g:hxs=0<Enter>m`hviWo``<Esc>`<vlB
nnoremap <silent> e :let g:hxs=0<Enter>m`lviw``<Esc>`>vhe
nnoremap <silent> E :let g:hxs=0<Enter>m`lviW``<Esc>`>vhE
nnoremap <silent> w :let g:hxs=0<Enter>m`lviw``<Esc>`>vwh
nnoremap <silent> W :let g:hxs=0<Enter>m`lviW``<Esc>`>vWh
xnoremap <expr> b (g:hxs ? '' : "\<Esc>m`hviwo``\<Esc>`<vl") .. 'b'
xnoremap <expr> B (g:hxs ? '' : "\<Esc>m`hviWo``\<Esc>`<vl") .. 'B'
xnoremap <expr> e (g:hxs ? '' : "\<Esc>m`lviw``\<Esc>`>vh") .. 'e'
xnoremap <expr> E (g:hxs ? '' : "\<Esc>m`lviW``\<Esc>`>vh") .. 'E'
xnoremap <expr> w (g:hxs ? '' : "\<Esc>m`lviw``\<Esc>`>vh") .. 'lwh'
xnoremap <expr> W (g:hxs ? '' : "\<Esc>m`lviW``\<Esc>`>vh") .. 'lWh'

" diff: only works on current line
nnoremap <silent> f :let g:hxs=0<Enter>vf
nnoremap <silent> t :let g:hxs=0<Enter>vlt
nnoremap <silent> F :let g:hxs=0<Enter>vF
nnoremap <silent> T :let g:hxs=0<Enter>vlT
xnoremap <expr> f (g:hxs ? '' : "\<Esc>v") .. 'f'
xnoremap <expr> t (g:hxs ? '' : "\<Esc>v") .. 'lt'
xnoremap <expr> F (g:hxs ? '' : "\<Esc>v") .. 'F'
xnoremap <expr> T (g:hxs ? '' : "\<Esc>v") .. 'lT'

" leave f/t hanging until a key is pressed
noremap f<F20> <Nop>
noremap t<F20> <Nop>
noremap F<F20> <Nop>
noremap T<F20> <Nop>

nnoremap G G0
xnoremap <expr> G 'G0' .. (g:hxs ? '' : "\<Esc>")

nnoremap <silent> <A-.> :let g:hxs=0<Enter>v;
xnoremap <expr> <A-.> (g:hxs ? '' : "\<Esc>v") .. ';'

xnoremap <expr> <Home> (g:hxs ? '' : "\<Esc>") .. '0'
xnoremap <expr> <End> (g:hxs ? '' : "\<Esc>") .. '$'
xnoremap <expr> <PageUp> (g:hxs ? '' : "\<Esc>") .. "\<C-b>"
xnoremap <expr> <PageDown> (g:hxs ? '' : "\<Esc>") .. "\<C-f>"
xnoremap <expr> <C-u> (g:hxs ? '' : "\<Esc>") .. "\<C-u>"
xnoremap <expr> <C-d> (g:hxs ? '' : "\<Esc>") .. "\<C-d>"
xnoremap <C-i> <Esc><C-i>v
xnoremap <C-o> <Esc><C-o>v

xmap <C-b> <PageUp>
xmap <C-f> <PageDown>

noremap <C-s> m'

" diff: doesn't work in ideavim
nnoremap <silent> <LeftDrag> :let g:hxs=0<Enter><LeftDrag>

"=== Changes ===

" diff: can't restore the selection due to operator ordering
" xnoremap r r
nnoremap <silent> R v"_c<C-r>"<Esc>:let g:hxs=0<Enter>v`<o
xnoremap <silent> R "_c<C-r>"<Esc>:let g:hxs=0<Enter>v`<o

nnoremap ~ v~
xnoremap ~ ~gv
nnoremap ` vu
xnoremap ` ugv
nnoremap <A-`> vU
xnoremap <A-`> Ugv

" diff: Helix keeps the selection during insert mode
if has('ide')
  xnoremap a <Esc>`>a
  xnoremap i <Esc>`<i
else
  xnoremap <expr> a mode() == 'v' ? "\<Esc>`>a" : 'A'
  xnoremap <expr> i mode() == 'v' ? "\<Esc>`<i" : 'I'
endif

xnoremap A <Esc>A
xnoremap I <Esc>I
xnoremap o <Esc>o
xnoremap O <Esc>O

" diff: Helix only repeats insertion, also keeps the selection
xnoremap . <Esc>`<.

" diff: Helix restores the selection
xnoremap u <Esc>u
nnoremap U <C-r>
xnoremap U <Esc><C-r>
nnoremap <A-u> g-
nnoremap <A-S-u> g+
xnoremap <A-u> <Esc>g-
xnoremap <A-S-u> <Esc>g+

nnoremap y yl
xnoremap <silent> y y:let g:hxs=0<Enter>gv
" diff: Helix adds to next line when pasting at end
nnoremap p pv`[o
nnoremap P Pv`[o
" diff: only works with unnamed register
xnoremap p <Esc>pv`[o
xnoremap P <Esc>`<Pv`<o

" diff: Helix keeps the cursor location
nnoremap > v>
nnoremap < v<
xnoremap <silent> > >:let g:hxs=0<Enter>gv
xnoremap <silent> < <:let g:hxs=0<Enter>gv

if has('ide')
  nnoremap <silent> = v:action ReformatCode<Enter>
  xnoremap <silent> = :action ReformatCode<Enter>gv
else
  nnoremap = v=gv<Esc>
  xnoremap = =gv
endif

nnoremap d vyi<Del><Esc>gvv
nnoremap <A-d> vvi<Del><Esc>gvv
xnoremap <A-d> "_d
nnoremap c vyi<Del>
nnoremap <A-c> v"_c
xnoremap <A-c> "_c

nnoremap <C-a> v<C-a>
nnoremap <C-x> v<C-x>
xnoremap <silent> <C-a> <C-a>:let g:hxs=0<Enter>gv
xnoremap <silent> <C-x> <C-x>:let g:hxs=0<Enter>gv

" diff: only works with register z, only works in normal mode in ideavim
noremap q @z
if has('ide')
  noremap Q qz
else
  noremap <expr> Q reg_recording() == '' ? 'qz' : 'q'
endif

"=== Shell ===

" diff: Helix selects the output
nnoremap <Bar> v:!
xnoremap <Bar> :!
nnoremap <A-Bar> v:! >/dev/null<C-Left><Left>
nnoremap <A-S-\> v:! >/dev/null<C-Left><Left>
xnoremap <A-Bar> :! >/dev/null<C-Left><Left>
xnoremap <A-S-\> :! >/dev/null<C-Left><Left>

if has('ide')
  noremap <expr> ! HelixCmdNotImplemented('shell_insert_output')
  noremap <expr> <A-!> HelixCmdNotImplemented('shell_append_output')
else
  nnoremap ! i<C-r>=trim(system(""))<Left><Left><Left>
  xnoremap ! <Esc>`<i<C-r>=trim(system(""))<Left><Left><Left>
  nnoremap <A-!> a<C-r>=trim(system(""))<Left><Left><Left>
  xnoremap <A-!> <Esc>`>a<C-r>=trim(system(""))<Left><Left><Left>
endif

noremap <expr> $ HelixCmdNotImplemented('shell_keep_pipe')

"=== Selections ===

noremap <expr> s HelixCmdNotImplemented('select_regex')
noremap <expr> S HelixCmdNotImplemented('split_selection')
noremap <expr> <A-s> HelixCmdNotImplemented('split_selection_on_newline')
noremap <expr> <A--> HelixCmdNotImplemented('merge_selections')
noremap <expr> <A-_> HelixCmdNotImplemented('merge_consecutive_selections')
noremap <expr> & HelixCmdNotImplemented('align_selections')
noremap <expr> _ HelixCmdNotImplemented('trim_selections')

nnoremap ; <Nop>
xnoremap ; <Esc>v
nnoremap <A-;> <Nop>
xnoremap <A-;> o

if has('ide')
  " diff: Helix keeps the bottom cursor, ideavim keeps top
  nnoremap , <Esc>
  xnoremap , <Esc><Esc>gv

  map C <Action>(EditorCloneCaretBelow)
  map <A-S-c> <Action>(EditorCloneCaretAbove)
else
  nnoremap , <Nop>
  xnoremap , <Esc>

  " diff: block selection as a stand-in for multiple cursors
  nnoremap <silent> C :let g:hxs=0<Enter><C-v>j
  xnoremap <expr> C mode() == 'v' ? "\<C-v>j" : 'j'
  nnoremap <silent> <A-S-c> :let g:hxs=0<Enter><C-v>k
  xnoremap <expr> <A-S-c> mode() == 'v' ? "\<C-v>k" : 'k'
endif

noremap <expr> <A-:> HelixCmdNotImplemented('ensure_selections_forward')
noremap <expr> <A-S-;> HelixCmdNotImplemented('ensure_selections_forward')
noremap <expr> <A-,> HelixCmdNotImplemented('remove_primary_selection')
noremap <expr> ( HelixCmdNotImplemented('rotate_selections_backward')
noremap <expr> ) HelixCmdNotImplemented('rotate_selections_forward')
noremap <expr> <A-(> HelixCmdNotImplemented('rotate_selection_contents_backward')
noremap <expr> <A-)> HelixCmdNotImplemented('rotate_selection_contents_forward')
noremap <expr> <A-S-9> HelixCmdNotImplemented('rotate_selection_contents_backward')
noremap <expr> <A-S-0> HelixCmdNotImplemented('rotate_selection_contents_forward')

nnoremap <silent> % :let g:hxs=0<Enter>gg0vG$
xnoremap % gg0oG$

" remapped as select_line_below/select_line_above
" diff: linewise visual so that yank/paste works as expected, causes some issues
nnoremap <silent> x :let g:hxs=0<Enter>V$
nnoremap <silent> X :let g:hxs=0<Enter>V0
xnoremap <expr> x col('.') > 1 && col('.') < col('$') ? 'V$' : 'j'
xnoremap <expr> X col('.') > 1 && col('.') < col('$') ? 'V$' : 'k'

nnoremap J v$wJgvov
xnoremap J m`$wJgv``

noremap <expr> <A-x> HelixCmdNotImplemented('shrink_to_line_bounds')
noremap <expr> <A-S-j> HelixCmdNotImplemented('join_selections_space')
noremap <expr> K HelixCmdNotImplemented('keep_selections')
noremap <expr> <A-S-k> HelixCmdNotImplemented('remove_selections')

if has('ide')
  nmap <C-c> v<Action>(CommentByLineComment)<Esc>
  "diff: Helix returns to normal mode
  xmap <C-c> <Action>(CommentByLineComment)
else
  noremap <expr> <C-c> HelixCmdNotImplemented('toggle_comments')
endif

noremap <expr> <A-Up> HelixCmdNotImplemented('expand_selection')
noremap <expr> <A-Down> HelixCmdNotImplemented('shrink_selection')
noremap <expr> <A-Left> HelixCmdNotImplemented('select_prev_sibling')
noremap <expr> <A-Right> HelixCmdNotImplemented('select_next_sibling')
map <A-o> <A-Up>
map <A-i> <A-Down>
map <A-p> <A-Left>
map <A-n> <A-Right>

"=== Search ===

" diff: Helix selects the match and adds to selections
nnoremap / /\v
nnoremap ? ?\v
xnoremap / <Esc>/\v
xnoremap ? <Esc>?\v

" diff: Helix adds match to selections
nnoremap <silent> n :let g:hxs=0<Enter>gn
nnoremap <silent> N :let g:hxs=0<Enter>gNo
xnoremap n <Esc>`>lgn
xnoremap N <Esc>`<hgNo

" diff: overwrites register s, potential escaping issues
nnoremap <silent> * v"sy:let @/ = "<C-r>s"<Enter>
xnoremap <silent> * "sy:let @/ = "<C-r>s"<Enter>gv

"=== View mode ===

noremap zc zz
noremap <expr> zm HelixCmdNotImplemented('align_view_middle')

noremap z<Up> <C-y>
noremap z<Down> <C-e>
noremap z<PageUp> <PageUp>
noremap z<PageDown> <PageDown>
noremap z<C-u> <C-u>
noremap z<C-d> <C-d>

map zk z<Up>
map zj z<Down>
map z<C-b> z<PageUp>
map z<C-f> z<PageDown>
map z<BS> z<C-u>
map z<Space> z<C-d>

map z/ /
map z? ?
map zN N
map zn n

noremap <expr> Z HelixCmdNotImplemented('sticky view mode')

"=== Goto mode ===

nnoremap ge G
" diff: doesn't work in ideavim
nnoremap <silent> gf :e <cfile><Enter>
nnoremap gh 0
nnoremap gl $
nnoremap gs ^
nnoremap gt H0
nnoremap gc M0
nnoremap gb L0
xnoremap <expr> gg (g:hxs ? '' : "\<Esc>") .. 'gg'
xnoremap <expr> ge (g:hxs ? '' : "\<Esc>") .. 'G'
" diff: overwrites register f
xnoremap <silent> gf "fy:<C-u>e <C-r>f<Enter>
xnoremap <expr> gh (g:hxs ? '' : "\<Esc>") .. '0'
xnoremap <expr> gl (g:hxs ? '' : "\<Esc>") .. '$'
xnoremap <expr> gs (g:hxs ? '' : "\<Esc>") .. '^'
xnoremap <expr> gt (g:hxs ? '' : "\<Esc>") .. 'H0'
xnoremap <expr> gc (g:hxs ? '' : "\<Esc>") .. 'M0'
xnoremap <expr> gb (g:hxs ? '' : "\<Esc>") .. 'L0'

if has('ide')
  map gd <Action>(GotoDeclaration)
  map gD <Action>(GotoDeclaration)
  map gy <Action>(GotoTypeDeclaration)
  map gr <Action>(ShowUsages)
  map gi <Action>(GotoImplementation)
else
  noremap <expr> gd HelixCmdNotImplemented('goto_definition')
  noremap <expr> gD HelixCmdNotImplemented('goto_declaration')
  noremap <expr> gy HelixCmdNotImplemented('goto_type_definition')
  noremap <expr> gr HelixCmdNotImplemented('goto_reference')
  noremap <expr> gi HelixCmdNotImplemented('goto_implementation')
endif

nnoremap ga <C-^>
xnoremap ga <Esc><C-^>
noremap <expr> gm HelixCmdNotImplemented('goto_last_modified_file')

if has('ide')
  map gn <Action>(NextTab)
  map gp <Action>(PreviousTab)
else
  nnoremap gn :next<Enter>
  nnoremap gp :prev<Enter>
  xnoremap gn <Esc>:next<Enter>
  xnoremap gp <Esc>:prev<Enter>
endif

nnoremap g. `.
xnoremap <expr> g. (g:hxs ? '' : "\<Esc>") .. '`.'

nnoremap gj j
nnoremap gk k
xnoremap <expr> gj 'j' .. (g:hxs ? '' : "\<Esc>")
xnoremap <expr> gk 'k' .. (g:hxs ? '' : "\<Esc>")

if has('ide')
  map gw <Action>(AceWordAction)
else
  noremap <expr> gw HelixCmdNotImplemented('goto_word')
endif

"=== Match mode ===

nnoremap mm %
xnoremap <expr> mm (g:hxs ? '' : "\<Esc>") .. '%'

noremap <expr> ms HelixCmdNotImplemented('surround_add')
noremap <expr> mr HelixCmdNotImplemented('surround_replace')
noremap <expr> md HelixCmdNotImplemented('surround_delete')

" diff: many differences in selectable text objects
nnoremap <silent> ma :let g:hxs=0<Enter>va
nnoremap <silent> mi :let g:hxs=0<Enter>vi
xnoremap <expr> ma (g:hxs ? '' : "\<Esc>v") .. 'a'
xnoremap <expr> mi (g:hxs ? '' : "\<Esc>v") .. 'i'

"=== Window mode ===

" diff: not implemented

"=== Space mode ===

map <Space>w <C-w>

map <Space>c <C-c>
map <Space><A-c> <C-c>

map <Space>y "*y
nmap <Space>p "*p
nmap <Space>P "*P
xnoremap <Space>p <Esc>"*pv`[o
xnoremap <Space>P <Esc>`<"*Pv`<o
nnoremap <silent> <Space>R v"_c<C-r>*<Esc>:let g:hxs=0<Enter>v`<o
xnoremap <silent> <Space>R "_c<C-r>*<Esc>:let g:hxs=0<Enter>v`<o

if has('ide')
  map <Space>f <Action>(GotoFile)
  map <Space>j <Action>(RecentLocations)
  map <Space>k <Action>(QuickJavaDoc)
  map <Space>s <Action>(FileStructurePopup)
  map <Space>S <Action>(GotoSymbol)
  map <Space>d <Action>(ActivateProblemsViewToolWindow)
  map <Space>r <Action>(RenameElement)
  map <Space>a <Action>(ShowIntentionActions)
  map <Space>C v<Action>(CommentByBlockComment)v
  map <Space>C <Action>(CommentByBlockComment)
  map <Space>/ <Action>(FindInPath)
  map <Space>? <Action>(GotoAction)
else
  noremap <expr> <Space>f HelixCmdNotImplemented('file_picker')
  noremap <expr> <Space>j HelixCmdNotImplemented('jumplist_picker')
  noremap <expr> <Space>k HelixCmdNotImplemented('hover')
  noremap <expr> <Space>s HelixCmdNotImplemented('symbol_picker')
  noremap <expr> <Space>S HelixCmdNotImplemented('workspace_symbol_picker')
  noremap <expr> <Space>d HelixCmdNotImplemented('diagnostics_picker')
  noremap <expr> <Space>r HelixCmdNotImplemented('rename_symbol')
  noremap <expr> <Space>a HelixCmdNotImplemented('code_action')
  noremap <expr> <Space>C HelixCmdNotImplemented('toggle_block_comments')
  noremap <expr> <Space>/ HelixCmdNotImplemented('global_search')
  noremap <expr> <Space>? HelixCmdNotImplemented('command_palette')
endif

noremap <expr> <Space>F HelixCmdNotImplemented('file_picker_in_current_directory')
noremap <expr> <Space>b HelixCmdNotImplemented('buffer_picker')
noremap <expr> <Space>g HelixCmdNotImplemented('changed_file_picker')
noremap <expr> <Space>G HelixCmdNotImplemented('debug')
noremap <expr> <Space>D HelixCmdNotImplemented('workspace_diagnostics_picker')
noremap <expr> <Space>h HelixCmdNotImplemented('select_references_to_symbol_under_cursor')
noremap <expr> <Space>' HelixCmdNotImplemented('last_picker')

"=== Unimpaired ===

" diff: text object boundaries different
nnoremap <silent> ]p :let g:hxs=0<Enter>v}
nnoremap <silent> [p :let g:hxs=0<Enter>v{
xnoremap <expr> ]p (g:hxs ? '' : "\<Esc>v") .. '}'
xnoremap <expr> [p (g:hxs ? '' : "\<Esc>v") .. '{'

if has('ide')
  " diff: Helix selects the object
  map ]d <Action>(GotoNextError)
  map [d <Action>(GotoPreviousError)
  map ]f <Action>(MethodDown)
  map [f <Action>(MethodUp)
  map ]g <Action>(VcsShowNextChangeMarker)
  map [g <Action>(VcsShowPrevChangeMarker)
else
  noremap <expr> ]d HelixCmdNotImplemented('goto_next_diag')
  noremap <expr> [d HelixCmdNotImplemented('goto_prev_diag')
  noremap <expr> ]f HelixCmdNotImplemented('goto_next_function')
  noremap <expr> [f HelixCmdNotImplemented('goto_prev_function')
  noremap <expr> ]g HelixCmdNotImplemented('goto_next_change')
  noremap <expr> [g HelixCmdNotImplemented('goto_prev_change')
endif

noremap <expr> ]D HelixCmdNotImplemented('goto_last_diag')
noremap <expr> [D HelixCmdNotImplemented('goto_first_diag')
noremap <expr> ]t HelixCmdNotImplemented('goto_next_class')
noremap <expr> [t HelixCmdNotImplemented('goto_prev_class')
noremap <expr> ]a HelixCmdNotImplemented('goto_next_parameter')
noremap <expr> [a HelixCmdNotImplemented('goto_prev_parameter')
noremap <expr> ]c HelixCmdNotImplemented('goto_next_comment')
noremap <expr> [c HelixCmdNotImplemented('goto_prev_comment')
noremap <expr> ]T HelixCmdNotImplemented('goto_next_test')
noremap <expr> [T HelixCmdNotImplemented('goto_prev_test')
noremap <expr> ]G HelixCmdNotImplemented('goto_last_change')
noremap <expr> [G HelixCmdNotImplemented('goto_first_change')

nnoremap [<Space> vvO<Esc>gvv
" diff: cursor moves in ideavim
nnoremap ]<Space> vvo<Esc>gvv
xnoremap [<Space> <Esc>O<Esc>gv
xnoremap ]<Space> <Esc>o<Esc>gv

"=== Insert mode ===

inoremap <C-s> <C-g>u
inoremap <C-x> <C-x><C-o>
inoremap <A-BS> <C-w>
inoremap <A-d> <C-o>de
inoremap <A-Del> <C-o>de
inoremap <C-k> <C-o>C
inoremap <C-d> <Del>

"=== Select/extend mode ===

nnoremap <silent> v :let g:hxs=1<Enter>v
xnoremap <silent> v <Esc>:let g:hxs=!g:hxs<Enter>gv

"=== Prompt ===

xnoremap : :<C-u>

cnoremap <A-b> <C-Left>
cnoremap <C-b> <Left>
cnoremap <A-f> <C-Right>
cnoremap <C-f> <Right>
cnoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <A-BS> <C-w>
cnoremap <C-BS> <C-w>
cnoremap <A-d> <C-Right><Right><C-w>
cnoremap <A-Del> <C-Right><Right><C-w>
cnoremap <C-Del> <C-Right><Right><C-w>
cnoremap <expr> <C-k> HelixCmdNotImplemented('kill_to_line_end')
cnoremap <C-d> <Del>
