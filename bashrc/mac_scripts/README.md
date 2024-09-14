# Mac OS

Note that on Mac os `.bashrc` is not automatically loaded, you need to add a
line that will load bashrc
```
# .bash_profile
[[ -s ~/.bashrc ]] && source ~/.bashrc
```
Install ag
```
brew install the_silver_searcher
```

# Karabiner

Key remap use karabiner
~~~
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
~~~

When you update karabiner you need to copy back to repo
```
cp ~/.config/karabiner/karabiner.json ~/config/.config/karabiner/karabiner.json
cp ~/config/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
```

# Keyboard shortcuts

For Keyboard Shortcuts we use **Automator** to run services which are located eg
`~/config/bashrc/mac_scripts/Library/Services/activateWindowH.workflow`

Inside service we call scripts which are written using **Script Editor** like
`~/config/bashrc/mac_scripts/mac_activate_window.scpt`

First copy all workflow folders
```
cp -r Library/Services/* ~/Library/Services/
# copy back the changes so we can save them in repo
cp -r ~/Library/Services/* Library/Services/
```
Go to Settings > Keyboard > Keyboard Shortcuts > Services > General >
and set shortcut for each service like activateWindowH is cmd+h

We need to rename existing shortcuts for example 'Jump to Selection' in Terminal
is cmd+j (Edit > Find > Jump to selection') so instead of manually adding each
in Keyboard Shortcuts > App Shortcuts > All Applications > +
we can add using the script and we need to log out to save the changes
Note that cmd is @, cmd+shift is @$
~~~
defaults read -g NSUserKeyEquivalents
defaults write -g NSUserKeyEquivalents -dict-add "Menu Item Name" "@r"
defaults write -g NSUserKeyEquivalents '{
    "Menu Item 1" = "@1";
    "Menu Item 2" = "@2";
}'
~~~

When we call scpt file from shell using osascript but we need to enable Privacy ->
Accessibility to Terminal
otherwise we get an error:
> /Users/dule/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt: execution error: System Events got an error: osascript is not allowed to send keystrokes. (1002)
https://stackoverflow.com/a/71826193/287166

Note that when you call the script, Script editor will think that file is
changed (probably end character is different), so you can click on "Revert".
Every time you make a change to script, please call the script and git add the
file after it is called.
We call scpt file from shell using osascript but we need to enable Privacy ->
Accessibility to Terminal
otherwise we get an error:
> /Users/dule/config/bashrc/mac_scripts/mac_run_command_in_slash_window.scpt: execution error: System Events got an error: osascript is not allowed to send keystrokes. (1002)
https://stackoverflow.com/a/71826193/287166

Mac will keep windowId and windowName inside `bashrc/mac_scripts/data.plist` so
you should
```
git update-index --no-assume-unchanged ~/config/bashrc/mac_scripts/data.plist
```
Bind new key with a `b` function.

TODO: add desktop number to window-number (no need to chrome since it will
automatically load current desktop window)
TODO: map ctrl + jk to up and down keys only inside safari and chrome
TODO: all_mac.sh should see enable variation of number of monitors
system_profiler SPDisplaysDataType | grep -w "Mirror:" | wc -l


Adding new key is by adding a property on `data.plist`
```
# ~/config/bashrc/mac_scripts/data.plist
	<key>windowId-colon</key>
	<integer>6417</integer>
...
	<key>windowName-colon</key>
	<string>Terminal</string>
```
