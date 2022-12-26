import { DirectUpload } from '@rails/activestorage'
import * as FilePond from 'filepond'

let FilePondRails = {
  directUploadUrl: null,
  input: null,
  default_options: {
    server: {
      process: (fieldName, file, metadata, load, error, progress, abort, transfer, options) => {
        const uploader = new DirectUpload(file, FilePondRails.directUploadUrl, {
          directUploadWillStoreFileWithXHR: (request) => {
            request.upload.addEventListener(
              'progress',
              event => progress(event.lengthComputable, event.loaded, event.total)
            )
          }
        })
        uploader.create((errorResponse, blob) => {
          if (errorResponse) {
            error(`Something went wrong: ${errorResponse}`)
          } else {
            const hiddenField = document.createElement('input')
            hiddenField.setAttribute('type', 'hidden')
            hiddenField.setAttribute('value', blob.signed_id)
            hiddenField.name = FilePondRails.input.name
            document.querySelector('form').appendChild(hiddenField)
            load(blob.signed_id)
          }
        })

        return {
          abort: () => abort()
        }
      },
      fetch: {
        url: './filepond/active_storage/fetch',
        method: 'POST',
        onload: (response) => {
          console.log(response)
          return response
        },
        ondata: (response) => {
          console.log(response)
          return response
        }
      },
      revert: {
        url: './filepond/active_storage/remove'
      },
      headers: {
        'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").content
      }
    }
  },

  // Convenience method to initialize FilePond based on the way this gem expects things to work
  create: function(input) {
    FilePondRails.directUploadUrl = input.dataset.directUploadUrl
    FilePondRails.input = input

    // Initialize FilePond on our element
    FilePond.create(input, FilePondRails.default_options)
  }
}

export {
  FilePond as FilePond,
  FilePondRails as FilePondRails
}
