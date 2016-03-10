#!/bin/bash
#
if [ "$1" = "-h" ]; then
  echo Update vim bundles. Use param --install to sync with the list
  exit 1
fi
list=(
  git://github.com/tpope/vim-rails.git # example: Rview
  git://github.com/tpope/vim-bundler.git # Bopen
  git://github.com/tpope/vim-fugitive.git # Gblame, Gbrowse: vim -u NONE -c "helptags vim-fugitive/doc" -c q
  git://github.com/tpope/vim-sensible.git # search before enter
  git://github.com/tpope/vim-cucumber.git # cucumber syntax highlight
  https://github.com/thoughtbot/vim-rspec.git # rspec shortcuts <Leader>tsla
  git://github.com/tpope/vim-endwise.git # auto insert end keyword
  https://github.com/alvan/vim-closetag.git # auto insert closing html tag( follow with > for new line)
  git://github.com/tpope/vim-surround.git # add tag `ysiw<em>` change `cst"` delete `ds"`. `S` in visual
  https://github.com/kchmck/vim-coffee-script.git # coffe files
  https://github.com/scrooloose/syntastic.git # syntax check jscs, rubocop
  https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline # nice statusline
  git://github.com/tpope/vim-repeat.git # repeat some plugin commands
  https://github.com/tpope/vim-unimpaired.git # [l ]q [a ]<space>
  https://github.com/ctrlpvim/ctrlp.vim.git # <c-p> <c-j> <c-k> <c-f> <c-b> <c-v>
  https://github.com/othree/html5.vim # html5 indent correct
  git://github.com/digitaltoad/vim-pug.git # jade syntax highlight
  https://github.com/tpope/vim-markdown.git # markdown 
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
  cd -
fi
for d in `ls ~/.vim/bundle`; do
  if [[ -d "${d}/.git" ]]; then
    echo "updating ${d}"
    cd $d
    git pull
    cd -
  fi
done
