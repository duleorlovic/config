" http://blog.trk.in.rs/2015/12/01/vim-tips/
" https://github.com/scrooloose/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
" let g:syntastic_debug = 1
" or run this command in vim (:let g:sy...) and than :mes

" RUBY
"let g:syntastic_ruby_exec = '/home/orlovic/.rvm/rubies/ruby-2.2.3/bin/ruby'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': [
    \ 'possibly useless use of a variable in void context',
    \ 'shadowing outer local variable',
    \ ]}
" this quit messages are also defined in ~/.rubocop.yml
let g:syntastic_ruby_rubocop_quiet_messages =
    \ {'regex': [
    \ 'Missing top-level class documentation comment.',
    \ ]}
" https://github.com/bbatsov/rubocop/issues/2162
let g:syntastic_ruby_rubocop_args = '--force-exclusion --display-cop-names'

" SCSS
" import 'variables' in all files that you use them so you don't get
" undefined variable error
" http://stackoverflow.com/questions/29041876/fixing-syntasticcheck-bootstrap-error-vim-syntastic-plugin
" problem File to import not found can be solved with
let g:syntastic_scss_sass_args="--load-path ~/.rvm/gems/ruby-2.2.3/gems/bootstrap-generators-3.3.4/vendor/twitter/bootstrap/sass"
      \ " --load-path vendor/assets/components"
      \ " --load-path vendor/assets/bower_components"
let g:syntastic_scss_sass_quiet_messages = 
    \ { 'regex': [
    \ 'Undefined mixin',
    \ 'Invalid CSS after "@charset',
    \ ] }

" JAVASCRIPT
let g:syntastic_javascript_checkers = ['eslint']

" JSON
au BufRead,BufNewFile *.json set filetype=json
let g:syntastic_json_checkers=['jsonlint']

" CSS
"let g:syntastic_scss_sass_args="--load-path ~/.rvm/gems/ruby-2.2.3/gems/normalize-rails-3.0.3/vendor/assets/stylesheets"
let g:syntastic_scss_checkers=['']

" Markdown
let g:syntastic_markdown_checkers=['']
