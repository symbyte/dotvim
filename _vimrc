let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'
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
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug  'mitermayer/vim-prettier', { 
	\ 'do': 'npm install', 
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] } 
Plug 'scrooloose/nerdcommenter'
Plug 'alvan/vim-closetag'
Plug 'jceb/vim-orgmode'
Plug 'airblade/vim-gitgutter'
Plug 'carlitux/deoplete-ternjs'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ensime/ensime-vim'
Plug 'derekwyatt/vim-scala'
Plug 'altercation/vim-colors-solarized'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neopairs.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/nvim-typescript'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'saltstack/salt-vim'
Plug 'lepture/vim-jinja'
Plug 'symbyte/vim-angular2-snippets'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Quramy/vim-js-pretty-template'
call plug#end()
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:deoplete#enable_at_startup = 1 
source $VIMRUNTIME/vimrc_example.vim
let g:ctrlp_working_path_mode='r'
let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git\|dist\|spec-compiled'
let g:gitgutter_realtime=1
let g:syntastic_always_populate_loc_list = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let NERDSpaceDelims=1
nnoremap <localleader>f :Prettier<CR>
"nnoremap <localleader>f :Autoformat<CR>

" neosnippets
" --------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" --------------------

" scala stuff
" ------------------------------
autocmd FileType scala map <buffer> <localleader>t :EnType<CR>
autocmd FileType scala map <buffer> <localleader>d :EnDocBrowse<CR>
autocmd FileType scala map <buffer> <localleader>b :EnDeclaration<CR>
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala='[^. *\t]\.\w*'
" ------------------------------

" typescript stuff
" ----------------------------

autocmd FileType typescript nmap <buffer> <localleader>t : <C-u>echo tsuquyomi#hint()<CR>
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript nmap <buffer> <localleader>d :TsuReferences<CR>
autocmd FileType typescript nmap <buffer> <localleader>r :TsuRenameSymbol<CR>
autocmd FileType typescript nmap <buffer> <localleader>i :TsuImport<CR>
autocmd FileType typescript nmap <buffer> <localleader>b :TsuDefinition<CR>
autocmd FileType typescript nmap <buffer> <localleader>v :TsuGoBack<CR>
autocmd FileType typescript nmap <buffer> <localleader>j :syn clear foldBraces <bar> JsPreTmpl html<CR>
autocmd FileType typescript nmap <buffer> <localleader>k :JsPreTmplClear<CR>
let g:tsuquyomi_disable_default_mappings = 1
let g:syntastic_typescript_checkers=['tsuquyomi', 'tslint']
let g:tsuquyomi_single_quote_import=1
let g:tsuquyomi_disable_quickfix=1
autocmd FileType typescript let b:autoformat_autoindent=0
let g:closetag_filenames="*.html"
" ----------------------------

"  Salt stuff
"  --------------------------------------
syntax on
set nocompatible
filetype plugin indent on
"  --------------------------------------

set updatetime=200
autocmd BufWritePost *.scala silent :EnTypeCheck

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
nnoremap <leader>jvr:!java %<<cr>
set background=dark
colorscheme solarized
cd $HOME/
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
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" prettier config
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" use tabs over spaces
let g:prettier#config#use_tabs = 'false'

" print semicolons
let g:prettier#config#semi = 'true'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true' 

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true' 

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'false' 

" none|es5|all
let g:prettier#config#trailing_comma = 'es5'

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = 'typescript'
