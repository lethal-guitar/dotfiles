set nocompatible

execute pathogen#infect()

" -------------------------------------------------------------------------
"  Settings
" -------------------------------------------------------------------------
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set number
set relativenumber
set hls is
set hidden
set cursorline
set showmode
set showcmd
set wildmenu
set clipboard=unnamedplus
set colorcolumn=80
set ignorecase
set smartcase
set gdefault
set backspace=indent,eol,start
set splitbelow
set splitright
set autowrite
set autoread
set noswapfile
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮

" Don't try to highlight very long lines
set synmaxcol=800

" Prevent beep
set visualbell
set noerrorbells

" YCM config
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_extra_conf_globlist = ['~/Uni/Masterarbeit/softvis-hpi/*']

" Local VimRC config
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

" NERDCommenter config
let NERDCreateDefaultMappings = 0

" vim-template config
let g:templates_no_autocmd = 1
let g:template_max_depth = 5

" AutoTidy
let g:enable_auto_tidy = 0

" Make search always very magic
nnoremap / /\v
vnoremap / /\v

" -------------------------------------------------------------------------
"  Augroups and related settings
" -------------------------------------------------------------------------

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

augroup various
    au!

    au BufNewFile,BufRead *.frag,*.vert,*.geom,*.fp,*.vp,*.glsl set ft=glsl
augroup END

" Perform some cleanup (whitespace removal, tabs to spaces etc.)
" on file save if enabled via variable.
" Also highlight unwanted whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red

augroup autoTidy
    au!

    " Redefine highlighting group on ColorScheme change
    au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

    match ExtraWhitespace /\s\+$/
    au BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au BufWinLeave * call clearmatches()

    au BufWritePre * call s:AutoTidy()
augroup END

" -------------------------------------------------------------------------
" Custom commands and functions
" -------------------------------------------------------------------------
command! TrimWs %s/\s\+$//ge
command! SudoWrite w !sudo tee % > /dev/null

function! s:AutoTidy()
    let l:enable_auto_tidy = g:enable_auto_tidy

    if exists('b:enable_auto_tidy')
        let l:enable_auto_tidy = l:enable_auto_tidy && b:enable_auto_tidy
    endif

    if l:enable_auto_tidy
        let save_cursor = getpos(".")
        TrimWs
        call setpos(".", save_cursor)

        retab
    endif
endfunction

" -------------------------------------------------------------------------
"  Key bindings
" -------------------------------------------------------------------------

let mapleader = "-"
map j gj
map k gk

" Switch between header/implementation files
map <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Switch tabs
map <C-S-Tab> :tabprevious<CR>
nmap <C-S-Tab> :tabprevious<CR>
imap <C-S-Tab> <Esc>:tabprevious<CR>i

map <C-Tab> :tabnext<CR>
nmap <C-Tab> :tabnext<CR>
imap <C-Tab> <Esc>:tabnext<CR>i

map <C-T> :tabnew<CR>

map <leader>c <plug>NERDCommenterToggle
nnoremap <silent> <leader>rw :call argumentrewrap#RewrapArguments()<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>n :noh<CR>

" delete line without yanking
map <leader>d "_dd

" Auto-indent (=) in function/block
map <leader>iif vi{=

" Quickfix next/previous
map <leader>q :cn<cr>
map <leader>Q :cprev<cr>

let g:UltiSnipsExpandTrigger = "<C-s>"
let g:UltiSnipsJumpForwardTrigger = "<C-s>n"
let g:UltiSnipsJumpBackwardTrigger = "<C-s>p"
