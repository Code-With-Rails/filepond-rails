# frozen_string_literal: true

module Filepond
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Filepond::Rails

      initializer 'filepond-rails.importmap', before: 'importmap' do |app|
        app.config.importmap.paths << Engine.root.join('config/importmap.rb')
        app.config.importmap.cache_sweepers << Engine.root.join('app/assets/javascripts')
      end

      initializer 'filepond-rails.assets.precompile' do |app|
        app.config.assets.precompile += %w( filepond-rails.js )
      end
    end
  end
end
