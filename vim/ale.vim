let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1
" keep `ruby` linter because I do not know how to disable
" warning: ambiguous first argument; put parentheses or a space even after `/' operator
" but can replace /#{var}/ with %r[#{var}]
" disable brakeman since it returns errors for all files so next location jumps
" to other file
let g:ale_linters = {'ruby':['rails_best_practices', 'reek', 'rubocop', 'solargraph']}
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'eruby': ['erubylint'],
" \}
highlight ALEWarning ctermbg=DarkMagenta
" disable ale for all subrepositories under real-world-rails
let g:ale_pattern_options = {
\ '.*real-world-rails.*': { 'ale_enabled': 0},
\}

" fix errors :help ale-fix-configuration
" does not work from vim ALEFix https://github.com/w0rp/ale/issues/732
nmap <F8> <Plug>(ale_fix)
let g:ale_fixers = {
\  'ruby': [
\    'rubocop'
\  ]
\}
