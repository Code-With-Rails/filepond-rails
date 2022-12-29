# frozen_string_literal: true

require 'application_system_test_case'
require 'dropybara'

class UploadsTest < ApplicationSystemTestCase
  setup do
    ActionController::Base.allow_forgery_protection = true
    visit(root_url)
  end

  teardown do
    ActionController::Base.allow_forgery_protection = false
  end

  test 'goes to homepage' do
    assert_selector 'h1', text: 'filepond-rails development'
  end

  test 'FilePond is loaded' do
    assert page.evaluate_script("typeof(FilePond) !== 'undefined'")
  end

  test 'FilePondRails is loaded' do
    assert page.evaluate_script("typeof(FilePondRails) !== 'undefined'")
  end

  test 'file upload via file upload' do
    assert_difference -> { ActiveStorage::Blob.count } do
      page.execute_script <<~JS
        window.filePondInstance.addFile("data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==")
        window.filePondInstance.processFile()
      JS
      sleep(5) # There is a delay in FilePond due to the UI providing feedback
    end
  end

  test 'file upload via fetch' do
    assert_difference -> { ActiveStorage::Blob.count }, 2 do
      page.execute_script <<~JS
        window.filePondInstance.addFile(
          'https://user-images.githubusercontent.com/16937/209497677-a0ace476-a04f-4efb-be8c-6d263ad5d0e0.png'
        )
        window.filePondInstance.processFile()
      JS
      sleep(5) # There is a delay in FilePond due to the UI providing feedback
    end
  end
end
