" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1 
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
" }}}

" override this from http://vim.wikia.com/wiki/Example_vimrc
set cmdheight=1  " 2 is to more
set number! " unset number

" to save history between vim session
set history=1000
" search grep current word
"nnoremap gw :vsplit<CR>:grep <cword> * -I -R --exclude-dir={log,public,tmp,vendor,db,bower_components,coverage,node_modules,dist,_site} --exclude={_coffeescript_build.js,tags}<CR>
nnoremap gw :Ack <cword><CR>
" search grep yanked word
" nnoremap gy :grep "<c-r>"" * --exclude-dir={log,public,tmp,vendor,db,bower_components,coverage,node_modules,dist,_site} -R -I --exclude={_coffeescript_build.js,tags}<CR>
nnoremap gy :Ack "<c-r>""<CR>
" https://github.com/beyondgrep/ack3/issues/330
let g:ackprg = 'ag --nogroup --nocolor --column --follow'
nnoremap // :Ack 

" this is for tab completion , to stop cycle press CTRL+E than tab
set wildmode=longest,list,full
" search selected text, press // while in visual mode
vnorem // y/<c-r>"<cr>
" change paste toggle key to F12 since F11 is maximize
set pastetoggle=<F12>

" remap leader to space
let mapleader = ' '
let maplocalleader = '\'

nnoremap <leader>e :NERDTreeToggle<CR>
" https://github.com/preservim/nerdtree/issues/1123#issuecomment-628737990
" let NERDTreeCustomOpenArgs = {'file':{'where':'p','keepopen':1,'stay':1}}
" let g:NERDTreeMapPreview = "<CR>"


" http://vim.wikia.com/wiki/Saving_a_file
nnoremap <Leader>q :q<CR>
"map <Esc><Esc> :w<CR> this move to insert move when I press up down arrows
nnoremap <leader>w :w<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>
" jump with jk to the first non blank line in the same column
" http://superuser.com/questions/755122/vim-move-to-first-non-blank-in-same-column
nnoremap <leader>j m':exec '/\%' . col(".") . 'c\S'<CR>``n
nnoremap <leader>k m':exec '?\%' . col(".") . 'c\S'<CR>``n
" remove any existing search highlight
nnoremap <Leader>/ :nohl<CR>
" search for next header in markdown file, so you can navigate with n and N
nnoremap <leader># /^#.*\n\n<cr>
" open some common rails files
nnoremap <leader>d :e config/database.yml<cr>
nnoremap <leader>s :e db/schema.rb<cr>
nnoremap <leader>r :e config/routes.rb<cr>
" nnoremap <leader>f :e spec/factories.rb<cr>
" nnoremap <leader>r :e config/routes.rb<cr> I use r for rubocop autofix
" https://github.com/ngmy/vim-rubocop
" nnoremap <leader>r :RuboCop --auto-correct<cr>
nnoremap <leader>f :ALEFix<cr>
nnoremap <leader>ed :e config/environments/development.rb<cr>
nnoremap <leader>ep :e config/environments/production.rb<cr>
" close search result window
" TODO not sure why I need another key for this map be executed
nnoremap <leader>c :cclose<cr>
" autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>

" http://stackoverflow.com/questions/10723700/how-can-vim-keep-the-content-of-register-when-pasting-over-selected-text
" keep current content of register when pasting
" vnoremap <Leader>p "_dP

" Map space to start visual selection same as it is in gnu screen
nnoremap <leader> v
" map space to yank so it is the same as in gnu screen
xnoremap <leader> y

" source current (probably) vim file
" nnoremap <leader>sop :source %<cr>
" nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>v :source $MYVIMRC<cr>

nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

nnoremap <F2> :write<CR>
vmap <F2> <Esc><F2>gv
" does not work when is in paste mode
imap <F2> <c-o><F2>
" webpacker reload sometimes miss write events so we need change how vim save
" https://github.com/webpack/webpack/issues/781#issuecomment-95523711
set backupcopy=yes

" function Test() range
"   echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| pbcopy')
" endfunction

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

"http://vim.wikia.com/wiki/Preview_output_from_interpreter_in_new_window
"save code, run ruby, show output in preview window
function! Ruby_eval_vsplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! ruby " . src . " > " . dst . " 2>&1 "
  execute ":pclose!"
  execute ":redraw!"
  execute ":vsplit"
  execute "normal \<C-W>l"
  execute ":e! " . dst
  execute ":set pvw"
  execute "normal \<C-W>h"
endfunction
vmap <silent> <F7> :call Ruby_eval_vsplit()<CR>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <Esc><F7>a
map <silent> <S-F7> <C-W>l:bw<CR>
imap <silent> <S-F7> <Esc><S-F7>a

"" Enable seeing-is-believing mappings only for Ruby
"augroup seeingIsBelievingSettings
"  autocmd!
"
"  autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
"  autocmd FileType ruby xmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
"
"  autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
"  autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
"  autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing-is-believing-mark)
"
"  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
"  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-run)
"augroup END

" some tips from https://github.com/thoughtbot/dotfiles/blob/master/vimrc
set autowrite " Automatically write before running commands

" cyrilic chars on macos are not displeyed properly, so use utf-8 encoding
set encoding=utf-8

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" this is obsolete since I remaped in xmodmap
" use ; instead of shift ; to go to command line
" nnoremap ; :
" force me to keep fingers on main keys, not shift+;
" nnoremap : :echoe "Use semicolon ;"<cr>

" force ctrl+j not enter, byebye return, force using main keys
" cmap <cr> <space>hey_use_ctrl_j_delete_this_with_ctrl_w_and_try_again_cr
" if you really need, use space<cr>
cnoremap <space><cr> <cr>
" gf uses :find _name_<cr> so we need to remap from vim-rails/autoload/rails.vim:4197
" tab uses =SuperTab('n')<cr> so we need to remap
imap <script> <Plug>SuperTabForward <c-r>=SuperTab('n') <cr>
" but this does not have effect, so I need to run it again on command line
" force ctrl+h for backspace
cnoremap <bs> <space>hey_use_ctrh_h_delete_this_with_ctrl_w

" convert uppercase to lowercase so: :E my_file -> :e my_file
" note that with `cmap E e` can not type uppercase E, for example:e ReADME.md
cabbrev E e


" Quicker window movement, shorthand of Ctrl+W+key
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-g> <C-w>h<C-w>h<C-w>h<C-w>h<C-w>h
nnoremap <C-:> <C-w>l<C-w>l<C-w>l<C-w>l<C-w>l
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb"

" yank and paste will interact with system clipboard so you can paste in browser
" http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
" set backup folder. first one which exists will be used
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " for backup a.txt~
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " for swap .a.txt.swp

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'wa' " check working directory with :pwd
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] " this has problem with unknown .git/
" ignore from .ctrlpignore https://github.com/kien/ctrlp.vim/issues/58
if filereadable(".ctrlpignore")
  let g:ctrlp_user_command = 'cd %s && git ls-files . -co --exclude-standard | grep -v "`cat .ctrlpignore`"'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif
" make ctrl-o immediatelly replace buffer so we don't need to answer OpenMulti prompt
" Open Selected: [t]ab/[v]ertical/[h]orizontal/[r]eplace/h[i]dden? 
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<down>'],
\ 'AcceptSelection("r")': ['<c-j>'],
\ }

" nmap <leader>t :CtrlPTag<CR>

" https://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
" reformat with gq
set textwidth=80
set colorcolumn=+1
" for html use double size
autocmd BufRead,BufNewFile *.html setlocal textwidth=160

" select my-name as it select my_name as words
set iskeyword+=-

" do not highlight current line since on mac it show lines on all lines
" set cursorline
" highlight current column
" set cuc cul"

" http://vim.wikia.com/wiki/Search_across_multiple_lines#Searching_over_multiple_lines_with_a_user_command
" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

" copy to clipboard on macOS need to use pbcopy
if has('macunix')
  vnoremap "+y :w !pbcopy <cr> <cr>
endif

" set folder for gutentags vim plugin
let g:gutentags_cache_dir = '~/.tags_cache'

" iabbrev command ⌘
" iabbrev option ⌥

" macos move those keys from standard position so remap them
" inoremap § `
" inoremap ± ~

nnoremap <F5> :UndotreeToggle<cr>

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

" operator pending search for end, delete block
onoremap b /end<cr>
onoremap in( :<c-u>normal! f(vi(<cr>

" remap <c-j> to <enter> so we do not need to distinguish this two keys
inoremap <c-j> <cr>
" insert new line and closing bracket after {<cr> and <c-j>
inoremap {<cr> {<cr>}<c-o><s-o>
inoremap ({<cr> ({<cr>})<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap ([<cr> ([<cr>])<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>
" also for do
" inoremap do<cr> do<cr>end<c-o><s-o>
" iabbrev do do<cr>end<c-o><s-o>

" write to another file and edit that file using command
" https://vi.stackexchange.com/questions/3458/save-current-file-and-open-another-for-editing
command! -nargs=1 -complete=file WE write <args> | edit <args>

" https://stackoverflow.com/questions/2250011/can-i-have-vim-ignore-a-license-block-at-the-top-of-a-file
function! FoldCopyright()
  if !exists( "b:foldedCopyright" )
    let b:foldedCopyright = 1
    silent! 1,/# Copyright/;/USA\.$/fold
  endif
endfunction
autocmd BufNewFile,BufRead *.rb call FoldCopyright()

" let test#strategy = "asyncrun"
" https://github.com/vim-test/vim-test
nmap <silent> <leader>n :TestNearest<CR>

" Vimscript file settings -----  {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" https://github.com/plasticboy/vim-markdown#disable-folding
let g:vim_markdown_folding_disabled = 1
" https://github.com/plasticboy/vim-markdown#adjust-new-list-item-indent
let g:vim_markdown_new_list_item_indent = 2

" jump with ctrl+j in quckfix window
augroup filetype_quickfix
    autocmd!
    autocmd FileType qf nnoremap <buffer> <c-j> <cr>:cclose<cr>
augroup END

" vim-impaired use [ ] but I replaced it with { }
nmap { [
nmap } ]
" use nore since we do not want recursively invoke with paragraph jump
noremap {{ {
noremap }} }

source $HOME/config/vim/ale.vim
source $HOME/config/vim/netrw.vim
source $HOME/config/vim/snippets/snippets.vim
source $HOME/config/vim/vim_rails.vim
source $HOME/config/vim/vim-test.vim

" for docker kubernetes yaml files, for terraform .tf files
" source $HOME/config/vim/coc.vim
" https://github.com/neoclide/coc.nvim/issues/617
" let g:endwise_no_mappings = 1
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#bad-background-highlight-of-floating-window
" autocmd vimenter * ++nested colorscheme gruvbox
" set background=dark
" let g:coc_disable_startup_warning = 1


" https://stackoverflow.com/a/9645147/287166
" nnoremap <silent> <leader>! :set opfunc=ProgramFilter<cr>g@
" vnoremap <silent> <leader>! :<c-u>call ProgramFilter(visualmode(), 1)<cr>
function! ProgramFilter(prog, vt, ...)
    let [qr, qt] = [getreg('"'), getregtype('"')]
    let [oai, ocin, osi, oinde] = [&ai, &cin, &si, &inde]
    setl noai nocin nosi inde=

    let [sm, em] = ['[<'[a:0], ']>'[a:0]]
    exe 'norm!`' . sm . a:vt . '`' . em . 'x'

    let out = system(a:prog, @")
    let out = substitute(out, '\n$', '', '')
    exe "norm!i\<c-r>=out\r"

    let [&ai, &cin, &si, &inde] = [oai, ocin, osi, oinde]
    call setreg('"', qr, qt)
endfunction

" vnoremap <silent> <leader>ts :<c-u>call ProgramFilter('translate.rb sr', visualmode(), 1)<cr>
" vnoremap <silent> <leader>te :<c-u>call ProgramFilter('translate.rb en', visualmode(), 1)<cr>
" vnoremap <silent> <leader>tc :<c-u>call ProgramFilter('cyrillizer.rb to_cyr', visualmode(), 1)<cr>
" vnoremap <silent> <leader>tl :<c-u>call ProgramFilter('cyrillizer.rb to_lat', visualmode(), 1)<cr>

" show filename in shell title https://askubuntu.com/a/589717/40031
autocmd BufEnter * let &titlestring = ' ' . expand("%:p")
set title

let g:airline_section_b = ''

" https://github.com/plasticboy/vim-markdown/issues/232#issuecomment-246173676
" when I reformat longer than 80 chars line in markdown, I do not need new bulle
autocmd FileType markdown 
    \ set formatoptions-=q |
    \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+

" https://github.com/nightsense/vimspectr
" colorscheme vimspectr330flat-dark
" https://apple.stackexchange.com/questions/295459/color-code-for-vi-on-terminal-on-mac
" set term=builtin_ansi

" My formats duleorlovic
" format gq till the end of current * item in markdown
" still do not know how to exclude and jump to previous line
noremap Q mqgqv/\(```\)\\|\*\s\|^$<cr>`q

" whereami
set errorformat+=%f%l%m
set grepprg=~/config/bin/whereami.rb
" move to function and use silent
" three <cr> one for execute, one for grep and one for copen to jump back to line
nnoremap <leader>w :execute ":grep %:p " . line('.') .  "\|clast\|copen"<cr><cr><cr>

" https://superuser.com/a/393948/877698
" use current line highlight inside current buffer
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

" reneable <c-[> since in karabiner we swap [ and {
nnoremap <c-{> <c-[>
nnoremap <c-}> <c-]>

" enable AutoSaveToggle automatically
let g:auto_save = 1

" when running inside screen with escape ^gg
" https://github.com/vim/vim/issues/15458#issuecomment-2277451413
set t_RB=

