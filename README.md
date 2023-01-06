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

Add to your `.bashrc` (or `.bash_profile` for MAC)

```
cat >> .bashrc <<HERE_DOC
if [ -f ~/config/my_bashrc.sh ]; then
  source ~/config/my_bashrc.sh
fi
HERE_DOC
```

Mac README is located `~/config/bashrc/mac_scripts/README.md` but here are
brief description:
Key remap use karabiner
~~~
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
~~~

For Keyboard Shortcuts we use Automator to create services which copied to
`~/config/bashrc/mac_scripts/Library/Services/activateWindowH.workflow`

Services are called on Keyboard Shortcuts. Inside service we call scripts which
are written using Script Editor like
`~/config/bashrc/mac_scripts/mac_activate_window.scpt`

We call scpt file from shell using osascript but we need to enable Privacy ->
Accessibility to Terminal
otherwise we get an error:
> /Users/dule/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt: execution error: System Events got an error: osascript is not allowed to send keystrokes. (1002)
https://stackoverflow.com/a/71826193/287166

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
