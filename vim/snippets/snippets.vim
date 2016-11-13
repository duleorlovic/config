" :read will insert below current line
" to insert in current line use join: kJ
"
" html snippet
nnoremap ,html :-1read $HOME/config/vim/snippets/skeleton.html<CR>3jwf>a
" jekylll {{ site.baseurl }}
nnoremap ,baseurl :read $HOME/config/vim/snippets/jekyll.baseurl.md<CR>kJ9whi
" <%= byebug %>
nnoremap ,bye :-1read $HOME/config/vim/snippets/byebug.erb<CR>
" minitest
nnoremap ,mini :-1read $HOME/config/vim/snippets/minitest.rb<CR>jjo
" rubocop disable common for one long function
nnoremap ,rubocop :-1read $HOME/config/vim/snippets/rubocop.rb<CR>
" font awesome
nnoremap ,fa :-1read $HOME/config/vim/snippets/fontawesome.html<CR>
" hacker rank template
nnoremap ,hacker :-1read $HOME/config/vim/snippets/hacker.rb<CR>
