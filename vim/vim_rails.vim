" configure vim-rails to jump to /spec instead of /test
" https://github.com/tpope/vim-rails/issues/426
"let g:rails_projections = {
"      \  'app/*.rb': {
"      \     'alternate': 'spec/{}_spec.rb',
"      \   },
"      \  'spec/*_spec.rb': {
"      \     'alternate': 'app/{}.rb',
"      \   }
"      \}
"
let g:rails_projections = {
\  "app/services/*.rb": {
\    "command": "service",
\    "template":
\      ["class {camelcase|capitalize|colons}", "end"],
\    "test": [
\      "test/services/{}_test.rb",
\      "spec/models/{}_spec.rb"
\    ],
\  },
\  "spec/features/*.rb": {
\    "command": "feature",
\  },
\  "app/concepts/*.rb": {
\    "command": "koncepts"
\  },
\  "app/*.slim": {
\    "command": "slim"
\  },
\  "app/concepts/*.haml": {
\    "command": "haml"
\  },
\  "app/assets/javascripts/backbone/apps/*": {
\    "command": "hamlc"
\  },
\  "app/concepts/*/operation": {
\    "command": "operation"
\  },
\  "spec/factories/*": {
\    "command": "factories",
\  },
\  "app/datatables/*.rb": {
\    "command": "datatables",
\  },
\  "app/controllers/api/v1/*_controller.rb": {
\    "command": "controllerapi"
\  },
\  "app/javascript/*.vue": {
\    "command": "vue",
\  },
\  "app/javascript/controllers/*_controller.js": {
\    "command": "javascriptcontrollers"
\  }
\}
