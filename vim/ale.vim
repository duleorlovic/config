let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'eruby': ['erubylint']}
highlight ALEWarning ctermbg=DarkMagenta
" disable ale for all subrepositories under real-world-rails
let g:ale_pattern_options = {
\ '.*real-world-rails.*': { 'ale_enabled': 0},
\}

