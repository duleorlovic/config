" ALEInfo will show all available linters
"
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {}
" Current Filetype: ruby
" ['brakeman', 'cspell', 'debride', 'rails_best_practices', 'reek', 'rubocop', 'ruby', 'solargraph', 'sorbet', 'standardrb']
" enable rubocop since rails comes with default .rubocop
" we can also use standardrb
" disable 'rails_best_practices' since it is not maintaned
" disable 'reek', since it is too much to fix it's checkings
" disable 'brakeman', since it is slow
let g:ale_linters.ruby = ['cspell', 'debride',  'reek', 'ruby', 'solargraph', 'sorbet', 'rubocop']

" Current Filetype: eruby
" Available Linters: ['erb', 'erblint', 'erubi', 'erubis', 'ruumba']
" Current Filetype: eruby.yaml
" ['erb', 'erblint', 'erubi', 'erubis', 'ruumba', 'actionlint', 'circleci', 'gitlablint', 'yaml-language-server', 'spectral', 'swaglint', 'yamllint']
" disable 'erblint' because <<: *DEFAULT is OK with a space, error:
" W: expected whitespace, '>', attribute name or value (at *)
let g:ale_linters.eruby =  ['erb', 'erubi', 'erubis', 'ruumba', 'actionlint', 'circleci', 'gitlablint', 'yaml-language-server', 'spectral', 'swaglint', 'yamllint']
" overwrite default ERB linter untill this is fixed
" https://github.com/dense-analysis/ale/issues/4167#issuecomment-1493808487
source ~/config/vim/ale_linters/eruby/erb.vim

" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'eruby': ['erubylint'],
" \}
highlight ALEWarning ctermbg=DarkMagenta
" disable ale for all subrepositories under real-world-rails
let g:ale_pattern_options = {
\ '.*real-world-rails.*': { 'ale_enabled': 0},
\}

" fix errors :help ale-fix-configuration you can run :ALEFix
"\    'rubocop --auto-correct --disable-uncorrectable'
nmap <F8> <Plug>(ale_fix)
let g:ale_fixers = {
\  'ruby': [
\    "standardrb"
\  ]
\}

" https://github.com/testdouble/standard/wiki/IDE:-vim
let g:ruby_indent_assignment_style = 'variable'

" disable yamllint since it gives document-start: missing document start
let g:ale_linters.yaml = ['actionlint', 'yaml-language-server', 'spectral']
