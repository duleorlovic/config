# Mac OS keyboard shortcuts

When you update karabiner you need to copy back to repo
```
cp ~/.config/karabiner/karabiner.json ~/config/.config/karabiner/karabiner.json
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
```

Bind new key with a `b` function.
TODO: add desktop number to window-number (no need to chrome since it will
automatically load current desktop window)
TODO: map ctrl + jk to up and down keys only inside safari and chrome

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

When we call scpt file from shell using osascript but we need to enable Privacy ->
Accessibility to Terminal
otherwise we get an error:
> /Users/dule/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt: execution error: System Events got an error: osascript is not allowed to send keystrokes. (1002)
https://stackoverflow.com/a/71826193/287166

Note that when you call the script, Script editor will think that file is
changed (probably end character is different), so you can click on "Revert".
Every time you make a change to script, please call the script and git add the
file after it is called.
