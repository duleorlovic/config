" :read will insert below current line
" to insert in current line use join: kJ
" to insert to current position use new line
"
" html snippet
nnoremap ,html :-1read $HOME/config/vim/snippets/skeleton.html<CR>3jwf>a
" jekylll {{ site.baseurl }} at current position
nnoremap ,baseurl r<CR>:-1read $HOME/config/vim/snippets/jekyll.baseurl.md<CR>kJ8ea
" <%= byebug %>
nnoremap ,bye :-1read $HOME/config/vim/snippets/byebug.erb<CR>
" minitest
nnoremap ,mini :-1read $HOME/config/vim/snippets/minitest.rb<CR>jjo
" rubocop disable common for one long function
nnoremap ,rubocop :-1read $HOME/config/vim/snippets/rubocop.rb<CR>
" font awesome
nnoremap ,fa :-1read $HOME/config/vim/snippets/fontawesome.html<CR>kJr<CR>
" hacker rank template
nnoremap ,hacker :-1read $HOME/config/vim/snippets/hacker.rb<CR>

" not really snippet, just replace :word => value with word: value
nnoremap ,: bhxelc2w: <ESC>

" rspec
nnoremap ,have_a ait { is_expected.to have_attribute  }<ESC>hi:

" erb
nnoremap ,< i<%=  %><ESC>hhi
nnoremap ,if i<% if  %><ESC>hhi
nnoremap ,el i<% else %><ESC>
nnoremap ,en i<% end %><ESC>
