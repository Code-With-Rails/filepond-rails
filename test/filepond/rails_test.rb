# frozen_string_literal: true

require 'test_helper'

module Filepond
  class RailsTest < ActiveSupport::TestCase
    test 'it has a version number' do
      assert Filepond::Rails::VERSION
    end
  end
end
