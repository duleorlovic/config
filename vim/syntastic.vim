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

" RUBY
"let g:syntastic_ruby_exec = '/home/orlovic/.rvm/rubies/ruby-2.2.3/bin/ruby'
let g:syntastic_ruby_checkers = ['rubocop'] ",'mri']
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}
" this quit messages are also defined in ~/.rubocop.yml
let g:syntastic_ruby_rubocop_quiet_messages =
    \ {'regex': [
    \ 'Missing top-level class documentation comment.',
    \ ]}
" https://github.com/bbatsov/rubocop/issues/2162
let g:syntastic_ruby_rubocop_args = '--force-exclusion --display-cop-names'

" SCSS
let g:syntastic_scss_sass_quiet_messages = 
    \ { 'regex': [
    \ 'Undefined mixin',
    \ 'Invalid CSS after "@charset',
    \ ] }

" JAVASCRIPT
" let g:syntastic_javascript_checkers = ['jscs']
