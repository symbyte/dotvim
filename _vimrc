function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
call plug#begin('~/.vim/plugged')
Plug 'elmcast/elm-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'alvan/vim-closetag'
Plug 'jceb/vim-orgmode'
Plug 'carlitux/deoplete-ternjs'
Plug 'w0ng/vim-hybrid'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'mhartington/deoplete-typescript', { 'do': function('DoRemote') }
call plug#end()
call deoplete#enable()
source $VIMRUNTIME/vimrc_example.vim
let g:ctrlp_working_path_mode='r'
let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git\|dist\|spec-compiled'
let $TMP = "c:/tmp"
let g:elm_format_autosave=1
set diffexpr=""
 function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
 endfunction
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>cp :!g++ -o %< %<cr>
nnoremap <leader>rn :!%<<cr>
nnoremap <leader>mk :!make<cr>
nnoremap <leader>cn :!make clean<cr>
nnoremap <leader>db :!gdb %<<cr>
nnoremap <leader>jvc :!javac %<cr>
nnoremap <leader>jvr :!java %<<cr>
colors hybrid
cd $HOME/
set autochdir
set nu!
set rnu!
set nobackup
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=2    " Indents will have a width of 4.
set softtabstop=2   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set noundofile
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-f> :NERDTreeToggle<CR>
"##############################################################################                                                                         
" Easier split navigation                                                                                                                               
"##############################################################################                                                                         

" Use ctrl-[up,down ,left right] to select the active split!
nmap <silent> <up> :wincmd k<CR>                                                                                                                       
nmap <silent> <down> :wincmd j<CR>                                                                                                                       
nmap <silent> <left> :wincmd h<CR>                                                                                                                       
nmap <silent> <right> :wincmd l<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
imap ii <Esc>
let g:indent_guides_guide_size = 1
let g:vim_markdown_folding_disabled = 1
"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR><CR>
