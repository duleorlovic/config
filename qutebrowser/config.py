
# Load the auto-configured settings
config.load_autoconfig()

# Custom configurations below
config.set('content.blocking.enabled', True)  # Enable ad-blocking
config.bind('xx', 'config-source')  # Bind 'xx' to reload the config file

# map cmd+1 to do alt+1 ie switch to tab 1
for i in range(1, 10):
    config.bind('<Super-{}>'.format(i), 'tab-focus {}'.format(i))

