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
cd ~
mkdir config/backup
find ~/config/ -maxdepth 1 -type f -printf "%f\n" | xargs mv -t ~/config/backup/
# alternative
find ~/config/ -maxdepth 1 -type f -exec basename {} \; | xargs mv -t ~/config/backup/
ls -la config/backup
# ignore errors since initially some file does not exists (we will create those files)
```

Now create a link for each file in config root folder
```
find ~/config/ -maxdepth 1 -type f -exec ln -s {} \;
```

Add to your `.bashrc`.

```
cat >> .bashrc <<HERE_DOC
if [ -f ~/config/my_bashrc.sh ]; then
  source ~/config/my_bashrc.sh
fi
HERE_DOC
```

Also `.config` files
```
ln -s ~/config/.config/gh/config.yml ~/.config/gh
```

# MAC specifics

Read in ~/config/bashrc/mac_scripts/README.md

## Vim plugin

Install vim and plugins

```
sudo apt install vim curl git vim-gtk
source ~/config/vim/update_vim_bundle.sh --install
# also links ftplugins
# ln -s /home/orlovic/config/vim/ftplugin/ /home/orlovic/.vim/
```

## Secret keys

Edit `config/keys/myapp.sh`
```
# config/keys/myapp.sh
export AWS_ACCESS_KEY_ID=asdasd
```
so you can use it
```
cd path/myapp
# edit
keys
# source
keys -s
```

## Keyboard shortcuts to jump between windows

I am using some
[xdotool](http://www.semicomplete.com/projects/xdotool)
https://github.com/jordansissel/xdotool
so you need to manually add some [keyboard
shortcuts](https://github.com/duleorlovic/config/blob/master/bashrc/window_shortcuts.sh#L34)

```
sudo apt install wmctrl xdotool xsel silversearcher-ag
```

On new ubuntu we use ydotool
https://github.com/ReimuNotMoe/ydotool/issues/36#issuecomment-788148567
https://askubuntu.com/questions/1400834/how-to-snap-minimize-maximize-window-below-cursor#comment2430196_1400835
but ydotool can issue keyboard strokes and mouse clicks, but lacks window
management features. A more severe Wayland problem: there is no uniform way to
obtain information about the running windows: it is the compositor that
implements that, so methods to achieve that are different between, Gnome Shell,
Plasma and Sway. – 


## Keyboard remapping

[xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys)
Add as [startup
application](https://github.com/duleorlovic/config/blob/master/.xbindkeysrc#L3)

Xmodmap works on Wayland inside Konsole (not default Terminal) app
Hide Menubar Ctrl+Shift+M (revert to show menubar on right click )

Update .screenrc file


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
