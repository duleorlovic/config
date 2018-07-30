let g:airline#extensions#ale#enabled = 1
" keep `ruby` linter because I do not know how to disable
" warning: ambiguous first argument; put parentheses or a space even after `/' operator
" but can replace /#{var}/ with %r[#{var}]
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'eruby': ['erubylint'],
\}
highlight ALEWarning ctermbg=DarkMagenta
" disable ale for all subrepositories under real-world-rails
let g:ale_pattern_options = {
\ '.*real-world-rails.*': { 'ale_enabled': 0},
\}

