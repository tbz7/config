let mapleader = ' '

inoremap fd <Esc>
vnoremap fd <Esc>
cnoremap fd <C-c>
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
map <C-b> <C-a>

nnoremap <C-w>\ <C-w>v
nnoremap <C-w>- <C-w>s

function! s:Nav(motion, reverse, direction)
  let l:old = winnr()
  execute 'wincmd ' . a:motion
  if l:old == winnr()
    if $TMUX == ''
      execute 'wincmd 10 ' . a:reverse
    else
      call system('tmux run -C "#{@force-select-pane-' . a:direction . '}"')
    endif
  endif
endfunction

noremap <silent> <M-h> :call <SID>Nav('h', 'l', 'l')<Enter>
noremap <silent> <M-j> :call <SID>Nav('j', 'k', 'd')<Enter>
noremap <silent> <M-k> :call <SID>Nav('k', 'j', 'u')<Enter>
noremap <silent> <M-l> :call <SID>Nav('l', 'h', 'r')<Enter>
inoremap <silent> <M-h> <Esc>:call <SID>Nav('h', 'l', 'l')<Enter>
inoremap <silent> <M-j> <Esc>:call <SID>Nav('j', 'k', 'd')<Enter>
inoremap <silent> <M-k> <Esc>:call <SID>Nav('k', 'j', 'u')<Enter>
inoremap <silent> <M-l> <Esc>:call <SID>Nav('l', 'h', 'r')<Enter>
noremap <M-H> 10<C-w>h
noremap <M-J> 10<C-w>j
noremap <M-K> 10<C-w>k
noremap <M-L> 10<C-w>l
inoremap <M-H> <Esc>10<C-w>h
inoremap <M-J> <Esc>10<C-w>j
inoremap <M-K> <Esc>10<C-w>k
inoremap <M-L> <Esc>10<C-w>l

nnoremap / /\v
cnoremap <expr> s/ getcmdline() =~ '\a' ? 's/' : 's/\v'
cnoremap <expr> p/ getcmdline() =~ '\a' ? 'p/' : "!perl -pe 's/'<Left>"

nmap <Enter> <C-l>j

nnoremap <silent> <Leader>l :set invnumber<Enter>
nnoremap <silent> <Leader>w :set invwrap<Enter>

cnoremap w!! SudaWrite

nnoremap <silent> <Leader>t :NvimTreeFindFileToggle<Enter>
nnoremap <silent> <Leader>ff :Telescope find_files<Enter>
nnoremap <silent> <Leader>fg :Telescope live_grep<Enter>
