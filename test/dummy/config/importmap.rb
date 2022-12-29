# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'filepond', to: 'https://ga.jspm.io/npm:filepond@4.30.4/dist/filepond.js', preload: true
pin '@rails/activestorage', to: 'https://ga.jspm.io/npm:@rails/activestorage@7.0.4/app/assets/javascripts/activestorage.esm.js'
