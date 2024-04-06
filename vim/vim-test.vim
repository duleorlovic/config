" https://github.com/janko-m/vim-test
" https://github.com/vim-test/vim-test
nmap <silent> <leader>n :TestNearest <CR>
nmap <silent> <leader>T :TestFile<CR>

" let test#ruby#minitest#options = '--verbose'

function! EchoStrategy(cmd)
  " on ubuntu we use xdotool_cmd_and_return
  " on mac we use apple script
  " execute 'Dispatch! xdotool_cmd_and_return.sh "'.a:cmd.'"'
  " execute 'Dispatch! osascript ~/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt "'.a:cmd.'"'
  execute 'Dispatch! is_mac_os && osascript ~/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt "'.a:cmd.'" || xdotool_cmd_and_return.sh "'.a:cmd.'"'
endfunction

let g:test#custom_strategies = {'echo': function('EchoStrategy')}
let g:test#strategy = 'echo'

" nnoremap <leader>rt :execute "Dispatch! rspec %"<cr>
" nnoremap <leader>rs :execute "Dispatch rspec %:" . line(".")<cr>
" nnoremap <leader>co :Copen<cr>

" nmap <silent> <leader>f :TestFile <CR>
" nmap <silent> <leader>a :TestSuite <CR>
" nmap <silent> <leader>l :TestLast <CR>
" nmap <silent> <leader>g :TestVisit <CR>

" NOT USED, REPLACED WITH JANKO
" RSpec.vim mappings for tests
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" vim-rspec-focus
" nnoremap <leader>ff :ToggleFocusTag <CR>
" nnoremap <leader>rf :RemoveAllFocusTags <CR>
