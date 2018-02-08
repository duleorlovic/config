let g:rails_projections = {
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "template":
      \     ["class {camelcase|capitalize|colons}", "end"],
      \   "test": [
      \     "test/services/{}_test.rb",
      \     "spec/models/{}_spec.rb"
      \   ],
      \ }}
