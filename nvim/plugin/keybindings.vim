let mapleader = ' '

inoremap fd <Esc>
vnoremap fd <Esc>
cnoremap fd <C-c>
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
map <C-b> <C-a>

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
