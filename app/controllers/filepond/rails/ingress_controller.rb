require 'open-uri'

module Filepond
  module Rails
    class IngressController < ApplicationController
      # FilePond calls this endpoint when a URL is dropped onto the
      # upload widget. The server acts as a "proxy" for the client in
      # order to load a file. We then redirect to the actual file
      # which is now served from our servers, and proceed through the
      # usual route.
      #
      # Note that the implementation below may not be the most efficient.
      # The alternative way would be to directly proxy the request to
      # the URL where the file is originally hosted.
      def fetch
        begin
          # We explicitly declare this for clarity of what is in the
          # raw_post value as sent by FilePond
          uri = URI.parse(raw_post)
          url = uri.to_s

          blob = ActiveStorage::Blob.create_and_upload!(
            io: URI.open(uri),
            filename: URI.parse(url).path.parameterize
          )

          redirect_to ::Rails.application.routes.url_helpers.rails_service_blob_path(
            blob.signed_id,
            blob.filename
          )
        # Why we casting such a wide net with StandardError (TL;DR: too many errors to catch):
        # See https://stackoverflow.com/a/46979718/20551849
        rescue StandardError
          head :unprocessable_entity
        end
      end

      # FilePond calls this endpoint when a user removes (ie. undos)
      # a file upload. This ensures that the blob is removed.
      def remove
        # We explicitly declare this for clarity of what is in the
        # raw_post value, as sent by FilePond
        signed_id = raw_post

        blob = ActiveStorage::Blob.find_signed(signed_id)
        if blob && blob.purge
          head :ok
        else
          # If we cannot find the blob, then we'll just return 404
          head :not_found
        end
      end

      private

      # FilePond sends the value (eg. file ID, URL, etc) and it comes
      # through as the POST body. We can retrieve that value with this
      # helper.
      def raw_post
        request.raw_post
      end
    end
  end
end
