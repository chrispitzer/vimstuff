syntax on
set background=dark
set showcmd		" Show (partial) command in status line.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set modeline           " Allow file inline modelines to provide settings
set backspace=start,eol,indent " Repair wired terminal/vim settings
set number
set mouse=a
set title

" The following turns on filetype detection, plugin, and indent
filetype plugin indent on

" set filetypes for template files
au BufRead,BufNewFile *.js.tmpl setf javascript
au BufRead,BufNewFile *.xml.tmpl setf xml
au BufRead,BufNewFile *.tmpl setf htmlcheetah

" set code completion for each filetype
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" highlight all search matches
"set hlsearch

" highlight matching parens for .4s
set showmatch
set matchtime=10

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab

set ruler
set laststatus=2

" Highlight bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.* match BadWhitespace /^\ \+/
au BufRead,BufNewFile *.* match BadWhitespace /\s\+$/

set wildmenu

" <F12>
function ShowMouseMode()
    if (&mouse == 'a')
        echo "MOUSE VIM"
    else
        echo "MOUSE X11"
    endif
endfunction
map <silent><F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

" Folding
" set foldmethod=indent
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

hi TabLine cterm=bold,underline ctermfg=8 ctermbg=none
hi TabLineSel cterm=bold ctermfg=3
hi TabLineFill cterm=bold ctermbg=none

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " set up some oft-used variables
        let tab = i + 1 " range() starts at 0
        let winnr = tabpagewinnr(tab) " gets current window of current tab
        let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
        let bufnr = buflist[winnr - 1] " current buffer number
        let bufname = bufname(bufnr) " gets the name of the current buffer in the current window of the current tab

        let s .= '%' . tab . 'T' " start a tab
        let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
        let s .= ' [' . tab " current tab number
        let n = tabpagewinnr(tab,'$') " get the number of windows in the current tab
        if n > 1
            let s .= ',' . n " if there's more than one, add a colon and display the count
        endif

        let bufmodified = getbufvar(bufnr, "&mod")
        if bufmodified
            let s .= '+'
        endif
        let s .= '] '
        if bufname != ''
            let s .= fnamemodify(bufname, ':t')
        else
            let s .= '-no name-'
        endif
    endfor
    let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
    let s .= '%T' " resets tab page number?
    let s .= '%=' " seperate left-aligned from right-aligned
    let s .= '%#TabLine#' " set highlight for the 'X' below
    let s .= '%999XX' " places an 'X' at the far-right
    return s
endfunction

set tabline=%!MyTabLine()

nmap \t A<lt>/<C-x><C-o><esc>
nmap \T :tabe<CR>\lf
nmap \ve :rightb vnew<CR>\lf
nmap \vr :rightb vsp<CR>\lr
nmap \se :rightb new<CR>\lf
nmap \sr :rightb sp<CR>\lr
cmap Q<CR> :q<CR>
cmap W<CR> :w<CR>
inoremap <Nul> <C-x><C-o>

" strip whitespace from document
nmap \<space> :let save_cursor=getpos(".")<CR>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:call setpos('.', save_cursor)<CR>

" note, <C-space> is omni-complete

" mapping for newlines...
map \<CR> A<CR><esc>


" navigating between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" setting up filetypes to use SnipMate with django snippets
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate

" pydiction
let g:pydiction_location = '~/.vim/pydiction/complete-dict'

map <F5> :JSLint<CR>

" map kj to <Esc> to exit insert mode
inoremap kj <Esc>
