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
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "template":
      \     ["class {camelcase|capitalize|colons}", "end"],
      \   "test": [
      \     "test/services/{}_test.rb",
      \     "spec/models/{}_spec.rb"
      \   ],
      \ },
      \ "spec/features/*.rb": {
      \   "command": "feature",
      \ },
      \ "spec/factories.rb": {
      \   "command": "factories",
      \ }
      \ }
