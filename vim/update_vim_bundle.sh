#!/bin/bash
#
pushd .
if [ "$1" = "-h" ]; then
  echo Update vim bundles. Use param --install to sync with the list
  exit 1
fi
list=(
  git://github.com/tpope/vim-rails.git # example: Rview
  git://github.com/tpope/vim-bundler.git # Bopen
  git://github.com/tpope/vim-fugitive.git # Gblame, Gbrowse: vim -u NONE -c "helptags vim-fugitive/doc" -c q
  https://github.com/tpope/vim-rhubarb.git # fugitive support for github
  https://github.com/tommcdo/vim-fubitive # support for bitbucket
  git://github.com/tpope/vim-sensible.git # search before enter
  git://github.com/tpope/vim-cucumber.git # cucumber syntax highlight
  git://github.com/tpope/vim-endwise.git # auto insert end keyword
  git://github.com/tpope/vim-surround.git # add tag `ysiw<em>` change `cst"` delete `ds"`. `S` in visual
  https://github.com/kchmck/vim-coffee-script.git # coffe files
  # https://github.com/scrooloose/syntastic.git # syntax check jscs, rubocop
  https://github.com/bling/vim-airline#  ~/.vim/bundle/vim-airline # nice statusline toolbar
  git://github.com/tpope/vim-repeat.git # repeat some plugin commands
  https://github.com/tpope/vim-unimpaired.git # [l ]q [a ]<space>
  https://github.com/ctrlpvim/ctrlp.vim.git # <c-p> <c-j> <c-k> <c-f> <c-b> <c-v>
  https://github.com/othree/html5.vim # html5 indent correct
  git://github.com/digitaltoad/vim-pug.git # jade syntax highlight
  # https://github.com/tpope/vim-markdown.git # is not used, since next one can
  # properly indent with 2 spaces
  https://github.com/michaeljsmith/vim-indent-object # text object based on indent
  https://github.com/plasticboy/vim-markdown.git # better since `` is properly
  # highlighted when intent is 4 spaces for multiline list item
  # https://github.com/plasticboy/vim-markdown/issues/126
  https://github.com/tomtom/tlib_vim.git # snipmate requirement
  https://github.com/MarcWeber/vim-addon-mw-utils.git # snipmate requirement
  https://github.com/garbas/vim-snipmate.git # snipmate
  https://github.com/honza/vim-snippets.git # spipmate snippets
  https://github.com/scrooloose/nerdtree.git # file explorer better than netrw
  git@github.com:tonekk/vim-ruby-capybara.git # capybara highlight
  https://github.com/sheerun/vim-polyglot.git # syntax & indent for multiple lang
  git@github.com:mbbill/undotree.git # vim graphical undo tree
  https://github.com/leafgarland/typescript-vim.git # typescript syntax
  git@github.com:mwise/vim-rspec-focus.git # add focus tag for rspec
  git@github.com:tpope/vim-commentary.git # comment code: gc
  git://github.com/tpope/vim-dispatch.git # async background task make test
  git@github.com:janko-m/vim-test.git # <leader>tTalg
  # git@github.com:skywind3000/asyncrun.vim.git # replacement for dispatch
  https://github.com/alvan/vim-closetag.git # auto insert closing html tag( follow with > for new line)
  https://github.com/mileszs/ack.vim.git # ack instead of grep
  https://github.com/w0rp/ale # instead of syntastic
  https://github.com/tpope/vim-ragtag.git # <%= %> tags
  https://github.com/kana/vim-textobj-user # base for some plugins
  https://github.com/kana/vim-textobj-line # vil val   # inner line without "\n" docs https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
  https://github.com/nelstrom/vim-textobj-rubyblock # vir
  https://github.com/lilydjwg/colorizer # colorize rgb colors
  https://github.com/stevearc/vim-arduino # arduino compile, flash and serial
)

# manually install https://github.com/kana/vim-textobj-user and some plugins
# https://github.com/nelstrom/vim-textobj-rubyblock # var vir visualy select inner ruby code
# https://github.com/kana/vim-textobj-line
#   cd ~/.vim/autoload
#   mkdir textobj
#   cd textobj/
#   wget https://raw.githubusercontent.com/kana/vim-textobj-user/master/autoload/textobj/user.vim
#   wget https://raw.githubusercontent.com/nelstrom/vim-textobj-rubyblock/master/plugin/textobj/rubyblock.vim

##### NOT USED ANY MORE
# https://github.com/lilydjwg/colorizer # highlight color #rgb #rrggbb
# I use some other plugin, for example rspec vim, and have mappings `<leader>t`
# to run test.  When I installed this colorizer plugin, I need to type another
# char after `t` (for example `<leader>tt`) to actually run the test. I think
# that there is some mappings in colorizer that prevent this

# https://bitbucket.org/ludovicchabant/vim-gutentags # to generate tags

# https://github.com/thoughtbot/vim-rspec.git # rspec shortcuts <Leader>tsla
# replaced with janko vim-test
#####

install_commands=(
  # https://github.com/tpope/vim-rhubarb
  "vim -u NONE -c 'helptags vim-rhubarb/doc' -c q"
  "vim -u NONE -c 'helptags vim-ragtag/doc' -c q"
)
if [ "$1" = "-i" ] || [ "$1" = "--install" ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

  cd ~/.vim/bundle
  # http://www.cyberciti.biz/faq/bash-for-loop-array/
  for bundle_link in "${list[@]}"
  do
    echo $bundle_link
    git clone $bundle_link
  done

  for install_command in "${install_commands[@]}"
  do
    echo $install_command
    $install_command
  done
  cd -
fi
echo start updating: `ls ~/.vim/bundle`
for d in `ls -d ~/.vim/bundle/*`; do
  if [[ -d "${d}/.git" ]]; then
    echo "updating ${d}"
    cd $d
    git pull
  fi
done
popd
