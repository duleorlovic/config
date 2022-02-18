# Mac OS keyboard shortcuts

When you update karabiner you need to copy back to repo
```
cp ~/.config/karabiner/karabiner.json ~/config/.config/karabiner/karabiner.json
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
```


Adding new key is by adding a property on `data.plist`
```
# ~/config/bashrc/mac_scripts/data.plist
	<key>windowId-colon</key>
	<integer>6417</integer>
...
	<key>windowName-colon</key>
	<string>Terminal</string>
```

Add also new `Automator` file `~/Library/Services/activateWindowColon.workflow`
I copy all automator services to my repo since it is simple one line and usually
we do not need to change it since it just calls `mac_activate_window.scpt` (you
need to edit scpt with `Script Editor`).
```
cp -r Library/Services/* ~/Library/Services/
# copy back the changes so we can save them in repo
cp -r ~/Library/Services/* Library/Services/
```
