import { FilePondRails, FilePond } from 'filepond-rails'

window.FilePond = FilePond
window.FilePondRails = FilePondRails

const input = document.querySelector('.filepond')
FilePondRails.create(input)
