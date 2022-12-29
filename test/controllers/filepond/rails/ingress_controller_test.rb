# frozen_string_literal: true

require 'test_helper'

module Filepond
  module Rails
    class IngressControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      # We're savages and will not stub this out
      def url
        'https://user-images.githubusercontent.com/16937/209497677-a0ace476-a04f-4efb-be8c-6d263ad5d0e0.png'
      end

      def fetch_request(url:)
        post active_storage_fetch_url, env: { 'RAW_POST_DATA' => url }
      end

      def blob
        @blob ||= ActiveStorage::Blob.create_and_upload!(
                    io: File.open(file_fixture('toronto.png')),
                    filename: 'toronto.png'
                  )
      end

      def remove_request(signed_id:)
        delete active_storage_remove_url, env: { 'RAW_POST_DATA' => signed_id }
      end

      test '#fetch creates blob' do
        assert_difference -> { ActiveStorage::Blob.count } do
          fetch_request(url:)
        end
      end

      test '#fetch redirects to blob' do
        fetch_request(url:)
        blob = ActiveStorage::Blob.last
        assert_redirected_to "/rails/active_storage/blobs/redirect/#{blob.signed_id}/#{blob.filename}"
      end

      test '#fetch responds with 422 if something goes wrong' do
        fetch_request(url: 'http://nonexistent/404')
        assert_response :unprocessable_entity
      end

      test '#remove purges blob' do
        signed_id = blob.signed_id

        assert_difference -> { ActiveStorage::Blob.count }, -1 do
          remove_request(signed_id:)
        end
      end

      test '#remove returns 200 if blob purged' do
        remove_request(signed_id: blob.signed_id)
        assert_response :ok
      end

      test '#remove returns 404 if blob not found' do
        signed_id = 'abcdefg'

        remove_request(signed_id:)
        assert_response :not_found
      end
    end
  end
end
