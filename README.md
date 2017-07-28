# Config files

I used those files to configure and enhance vim, bash, ubuntu...

~~~
cd ~
git clone git@github.com:duleorlovic/config.git
~~~

If you make a lot of changes to initial file make sure you mv original files
to back backup

~~~
find ~/config/ -maxdepth 1 -type f -printf "%f\n" | xargs mv -t ~/config/backup/
find ~/config/ -maxdepth 1 -type f -exec basename {} \; | xargs mv -t ~/config/backup/
# ignore errors if some file does not exists because we will create those files

# create link for each file in config
find ~/config/ -maxdepth 1 -type f -exec ln -s {} \;
~~~

Add to your `.bashrc` (or `.bash_profile` for MAC)

~~~
cat >> .bashrc <<HERE_DOC
if [ -f ~/config/my_bashrc.sh ]; then
  source ~/config/my_bashrc.sh
fi
HERE_DOC
~~~

Install vim pathogen and plugins

~~~
sudo apt install vim curl xsel git vim-gtk xdotool
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
source ~/config/vim/update_vim_bundle.sh --install
~~~

## Secret keys

Edit `config/my_bashrc.sh` to include your `~/config/keys/project_keys.sh`

~~~
cat > ~/config/keys/my_keys.sh <<HERE_DOC
export AWS_ACCESS_KEY_ID=asdasd
export AWS_SECRET_ACCESS_KEY=asdasd
export MAIL_INTERCEPTOR_EMAIL=asd@asd.asd
export MANDRILL_API_KEY=asdasd
HERE_DOC
~~~

# Keyboard shortcuts for windows

I am using some
[xdotool](http://www.semicomplete.com/projects/xdotool/xdotool.xhtml)
so you need to manually add some [keyboard
shortcuts](https://github.com/duleorlovic/config/blob/master/bashrc/window_shortcuts.sh#L34)

# Keyboard remapping

[xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys)
Add as [startup
application](https://github.com/duleorlovic/config/blob/master/.xbindkeysrc#L3)

