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
set hls is
set hidden
set clipboard=unnamedplus
set colorcolumn=80
set ignorecase
set smartcase
set backspace=indent,eol,start

" Prevent beep
set visualbell
set noerrorbells

" Highlight extraneous whitespace
match Todo /\s\+$/

" YCM config
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimCompletionMethod = 'omnifunc'
" let g:ycm_filetype_specific_completion_to_disable = {'php': 1}

" -------------------------------------------------------------------------
"  Autorun
" -------------------------------------------------------------------------
if has("autocmd")

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

  autocmd VimEnter * NERDTree

  au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

  augroup END

else
  set autoindent        " always set autoindenting on
endif " has("autocmd")

" -------------------------------------------------------------------------
" Custom commands
" -------------------------------------------------------------------------
command! TrimWs %s/\s\+$//g

" -------------------------------------------------------------------------
"  Key bindings
" -------------------------------------------------------------------------

" Switch between header/implementation files
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Switch tabs
map <C-S-Tab> :tabprevious<CR>
nmap <C-S-Tab> :tabprevious<CR>
imap <C-S-Tab> <Esc>:tabprevious<CR>i

map <C-Tab> :tabnext<CR>
nmap <C-Tab> :tabnext<CR>
imap <C-Tab> <Esc>:tabnext<CR>i

nnoremap <silent> <F2> :call argumentrewrap#RewrapArguments()<CR>
