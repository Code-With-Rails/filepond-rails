module Filepond
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Filepond::Rails
    end
  end
end
