set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore=*.swp,*.bak,*.pyc,*.class

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set history=1000                  " remember more commands and search history
set undolevels=1000               " use many muchos levels of undo
set title                         " change the terminal's title
set visualbell                    " don't beep
set noerrorbells                  " don't beep


set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

" UNCOMMENT TO USE
"set tabstop=2                    " Global tab width.
"set shiftwidth=2                 " And again, related.
"set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time

" Whitespace control. Expandtab uses spaces instead of tabs. 
set ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

" Show invisibles
set list

" Or use vividchalk
colorscheme ir_black

" LEADER

let mapleader = ","

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

let g:LustyExplorerSuppressRubyWarning = 1

" Uncomment to use Jamis Buck's file opening plugin
" map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax shiftwidth=2 tabstop=2
autocmd FileType css  setlocal shiftwidth=2 tabstop=2
autocmd FileType haml setlocal foldmethod=syntax shiftwidth=2 tabstop=2

" Custom Mappings
nmap <leader>nt :NERDTree<cr>
nmap <leader>s  :w<cr>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Mimics TextMate's Indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

"gui options {{{ 

if has('gui_running')
    set columns=160                                                     "set width of window off open
    set lines=50                                                        "height of window off open
    set guitablabel=%t                                                  "tabs display file name

    "kick it old school, no gui needed.
    set guioptions-=T                                                   "kill toolbar
    set guioptions-=m                                                   "kill menu
    set guioptions-=r                                                   "kill right scrollbar
    set guioptions-=l                                                   "kill left scrollbar
    set guioptions-=L                                                   "kill left scrollbar with multiple buffers
endif

"}}}

command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction
" 

"Git branch
function! GitBranch()
    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if branch != ''
        return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
    en
    return ''
endfunction

function! CurDir()
    return substitute(getcwd(), '/Users/amir/', "~/", "g")
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

call pathogen#runtime_append_all_bundles()

" Useful status information at bottom of screen
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L%{GitBranch()}

" Map enter to escape
inoremap <cr> <esc>
nnoremap <cr> a<cr>

