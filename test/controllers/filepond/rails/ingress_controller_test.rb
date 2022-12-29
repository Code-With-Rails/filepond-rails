# frozen_string_literal: true

require 'test_helper'

module Filepond
  module Rails
    class IngressControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers
    end
  end
end
