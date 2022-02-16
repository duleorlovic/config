# Config files

I used those files to configure and enhance vim, bash, ubuntu...

## Getting started

```
cd ~
git clone git@github.com:duleorlovic/config.git
```

If you already made a lot of changes to initial .dot files make sure you mv
those original files to backup location

```
find ~/config/ -maxdepth 1 -type f -printf "%f\n" | xargs mv -t ~/config/backup/
find ~/config/ -maxdepth 1 -type f -exec basename {} \; | xargs mv -t ~/config/backup/
# ignore errors if some file does not exists because we will create those files
```

Now create a link for each file in config root folder
```
find ~/config/ -maxdepth 1 -type f -exec ln -s {} \;
```

Add to your `.bashrc` (or `.bash_profile` for MAC)

```
cat >> .bashrc <<HERE_DOC
if [ -f ~/config/my_bashrc.sh ]; then
  source ~/config/my_bashrc.sh
fi
HERE_DOC
```

For MAC also copy karabiner
~~~
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
~~~

## Vim plugin

Install vim pathogen and plugins

```
sudo apt install vim curl xsel git vim-gtk xdotool
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
source ~/config/vim/update_vim_bundle.sh --install
# also links ftplugins
ln -s /home/orlovic/config/vim/ftplugin/ /home/orlovic/.vim/
```

## Secret keys

Edit `config/my_bashrc.sh` to include your `~/config/keys/project_keys.sh`

```
cat > ~/config/keys/my_keys.sh <<HERE_DOC
export AWS_ACCESS_KEY_ID=asdasd
export AWS_SECRET_ACCESS_KEY=asdasd
export MAIL_INTERCEPTOR_EMAIL=asd@asd.asd
export MANDRILL_API_KEY=asdasd
HERE_DOC
```

## Keyboard shortcuts for windows

I am using some
[xdotool](http://www.semicomplete.com/projects/xdotool)
https://github.com/jordansissel/xdotool
so you need to manually add some [keyboard
shortcuts](https://github.com/duleorlovic/config/blob/master/bashrc/window_shortcuts.sh#L34)

## Keyboard remapping

[xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys)
Add as [startup
application](https://github.com/duleorlovic/config/blob/master/.xbindkeysrc#L3)


## Contributing

Bug reports and pull requests are welcome on GitHub at
[github.com/duleorlovic/config/issues].
Thank you [contributors]!

[github.com/duleorlovic/config/issues]: https://github.com/duleorlovic/config/issues
[contributors]: https://github.com/duleorlovic/config/graphs/contributors

## License

The project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

## Authors

This project is designed and created at TRK INNOVATIONS LLC by:

* [duleorlovic](https://github.com/duleorlovic)
