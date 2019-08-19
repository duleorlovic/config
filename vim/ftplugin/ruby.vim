" https://github.com/janko-m/vim-test
" nnoremap <leader>rt :execute "Dispatch! rspec %"<cr>
" nnoremap <leader>rs :execute "Dispatch rspec %:" . line(".")<cr>
" nnoremap <leader>co :Copen<cr>
function! EchoStrategy(cmd)
  let current_window = system('xdotool getactivewindow | tr -d "\n"')
  let target_window = system('source ~/config/bashrc/get_current_viewport.sh && xdotool search --classname vp_$(get_current_viewport)_class_slash | tr -d "\n"')
  execute 'Dispatch! xdotool windowactivate --sync '.target_window.' type "'.a:cmd.'"; xdotool key --delay 10 space Return windowactivate '.current_window
endfunction

let g:test#custom_strategies = {'echo': function('EchoStrategy')}
let g:test#strategy = 'echo'
nmap <silent> <leader>n :TestNearest <CR>
nmap <silent> <leader>f :TestFile <CR>
nmap <silent> <leader>a :TestSuite <CR>
nmap <silent> <leader>l :TestLast <CR>
nmap <silent> <leader>g :TestVisit <CR>

" NOT USED, REPLACED WITH JANKO
" RSpec.vim mappings for tests
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" vim-rspec-focus
" nnoremap <leader>ff :ToggleFocusTag <CR>
" nnoremap <leader>rf :RemoveAllFocusTags <CR>
