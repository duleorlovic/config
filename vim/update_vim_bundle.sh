#!/bin/bash
#
pushd .
if [ "$1" = "-h" ]; then
  echo Update vim bundles. Use param --install to sync with the list
  exit 1
fi
list=(
  git@github.com:dense-analysis/ale.git # instead of syntastic
  git@github.com:907th/vim-auto-save.git
  git@github.com:tpope/vim-rails.git # example: Rview
  git@github.com:tpope/vim-bundler.git # Bopen
  git@github.com:tpope/vim-fugitive.git # Gblame, Gbrowse: vim -u NONE -c "helptags vim-fugitive/doc" -c q
  git@github.com:tpope/vim-rhubarb.git # fugitive support for github
  git@github.com:tommcdo/vim-fubitive.git # support for bitbucket
  git@github.com:tpope/vim-sensible.git # default vimrc conf like search before enter
  git@github.com:tpope/vim-cucumber.git # cucumber syntax highlight
  git@github.com:tpope/vim-endwise.git # auto insert end keyword
  git@github.com:tpope/vim-surround.git # add tag `ysiw<em>` change `cst"` delete `ds"`. `S` in visual
  # https://github.com/kchmck/vim-coffee-script.git # coffe files
  # https://github.com/scrooloose/syntastic.git # syntax check jscs, rubocop
  # git://github.com/vim-ruby/vim-ruby.git
  # https://github.com/ngmy/vim-rubocop # autofix
  git@github.com:vim-airline/vim-airline.git #  ~/.vim/pack/my_start_plugins/start/vim-airline # nice statusline toolbar
  git@github.com:tpope/vim-repeat.git # repeat some plugin commands
  git@github.com:tpope/vim-unimpaired.git # [l ]q [a ]<space>
  git@github.com:ctrlpvim/ctrlp.vim.git # <c-p> <c-j> <c-k> <c-f> <c-b> <c-v>
  git@github.com:othree/html5.vim.git # html5 indent correct
  git@github.com:digitaltoad/vim-pug.git # jade syntax highlight
  # https://github.com/tpope/vim-markdown.git # is not used, since next one can
  # properly indent with 2 spaces
  # git@github.com:michaeljsmith/vim-indent-object.git # text object based on indent
  # git@github.com:preservim/vim-markdown.git # better since `` is properly
  # highlighted when intent is 4 spaces for multiline list item
  # but it always fold headers so we will not use this plugin
  # https://github.com/plasticboy/vim-markdown/issues/126
  # https://github.com/tomtom/tlib_vim.git # snipmate requirement
  # https://github.com/MarcWeber/vim-addon-mw-utils.git # snipmate requirement
  # https://github.com/garbas/vim-snipmate.git # snipmate
  # https://github.com/honza/vim-snippets.git # spipmate snippets
  git@github.com:preservim/nerdtree.git # file explorer better than netrw
  # git@github.com:tonekk/vim-ruby-capybara.git # capybara highlight
  git@github.com:sheerun/vim-polyglot.git # syntax & indent for multiple lang
  # git@github.com:mbbill/undotree.git # vim graphical undo tree
  git@github.com:leafgarland/typescript-vim.git # typescript syntax
  git@github.com:mwise/vim-rspec-focus.git # add focus tag for rspec
  git@github.com:tpope/vim-commentary.git # comment code: gc
  git@github.com:tpope/vim-dispatch.git # async background task make test
  git@github.com:janko-m/vim-test.git # <leader>tTalg
  # git@github.com:skywind3000/asyncrun.vim.git # replacement for dispatch
  git@github.com:alvan/vim-closetag.git # auto insert closing html tag( follow with > for new line)
  git@github.com:mileszs/ack.vim.git # ack instead of grep
  git@github.com:tpope/vim-ragtag.git # <%= %> tags
  git@github.com:kana/vim-textobj-user.git # base for some my_start_plugins
  git@github.com:kana/vim-textobj-line.git # vil val   # inner line without "\n" docs https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
  git@github.com:nelstrom/vim-textobj-rubyblock.git # vir
  git@github.com:lilydjwg/colorizer.git # colorize rgb colors
  git@github.com:stevearc/vim-arduino.git # arduino compile, flash and serial
  git@github.com:chrisbra/csv.vim.git # :Header vG:ArrangeColumn
  # git@github.com:ervandew/supertab.git # tab completion error when enabled
  git@github.com:yegappan/taglist.git
  git@github.com:neoclide/coc.nvim.git # vscode
  git@github.com:morhetz/gruvbox.git  # new color scheme
  # git@github.com:pearofducks/ansible-vim.git
)

# manually install https://github.com/kana/vim-textobj-user and some
# my_start_plugins
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

#  # https://github.com/tpope/vim-rhubarb
#  "vim -u NONE -c 'helptags vim-rhubarb/doc' -c q"
#  "vim -u NONE -c 'helptags vim-ragtag/doc' -c q"
install_commands=(
  "cd ~/.vim/pack/my_start_plugins/start/coc.nvim/ && yarn install && cd -"
)
if [ "$1" = "-i" ] || [ "$1" = "--install" ]; then
  # Vim 8+ autoloads pack/*/start directory `:help packages`
  mkdir -p ~/.vim/pack/my_start_plugins/start

  cd ~/.vim/pack/my_start_plugins/start
  # http://www.cyberciti.biz/faq/bash-for-loop-array/
  for bundle_link in "${list[@]}"
  do
    echo git clone $bundle_link
    folder=$(basename $bundle_link)
    folder_without_extension="${folder%.*}"
    [ ! -d $folder_without_extension ] && git clone $bundle_link
    echo git clone $bundle_link done
  done

  for install_command in "${install_commands[@]}"
  do
    echo $install_command
    eval $install_command
  done
  cd -
else
  echo start updating: `ls ~/.vim/pack/my_start_plugins/start`
  for d in `ls -d ~/.vim/pack/my_start_plugins/start/*`; do
    if [[ -d "${d}/.git" ]]; then
      echo "cd ${d}"
      cd $d
      echo git pull
      git pull
    fi
  done
  popd
fi
