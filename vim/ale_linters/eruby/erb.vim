" https://github.com/dense-analysis/ale/issues/4167#issuecomment-1493808487
function! ale_linters#eruby#erb#GetCommand(buffer) abort
    return 'ruby -r erb -e ' . ale#Escape('puts ERB.new($stdin.read.gsub(%{<%=},%{<%})).src') . '< %t | ruby -c'
endfunction
