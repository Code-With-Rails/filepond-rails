# frozen_string_literal: true

pin 'filepond', to: 'https://ga.jspm.io/npm:filepond@4.30.4/dist/filepond.js', preload: true
pin_all_from File.expand_path("../app/assets/javascripts", __dir__)
