'use strict'

describe 'Directive: file-chooser', ->
    successCallback = {}
    files = ['tush.png', 'bad_girl.png']

    beforeEach module 'common'
    beforeEach module 'templates'

    element = {}

    compileElement = (files) ->
        element = new TestElement 'file-chooser'
        element.create '<file-chooser files="files"></file-chooser>',
            files: files

    describe 'binding files after compile', ->
        beforeEach (done) ->
            compileElement(files)
            done()

        it 'should bind element scope files to files', () ->
            expect(element.scope.files).toEqual(files)

        it 'should assign empty string to fileName', ->
            expect(element.scope.fileName).toEqual('')

        it 'shouldn\'t have button to delete image file', ->
            expect(element.dom.find('md-icon.delete').length).toBe(0)

     describe 'scope.removeFile function', ->
         beforeEach ->
             element.scope.removeFile()

         it 'should assign empty array to scope.files and empty string to fileName', ->
             expect(element.scope.files).toEqual([])
             expect(element.scope.fileName).toEqual('')

     describe 'scope.changeFile function', ->
         event =
             target:
                 files: [
                     { name: 'LaGrange.png' },
                     { name: 'SharpDressedMan.png' }
                 ]
         beforeEach ->
             element.scope.changeFile(event)

         it 'should change scope.files to array from event.target.files and fileName to first name from that filenames', ->
             expect(element.scope.files).toEqual(event.target.files)
             expect(element.scope.fileName).toEqual('LaGrange.png')

         it 'should have visible element md-icon making possible for user to remove image file before post submit', ->
             expect(element.dom.find('md-icon.delete').length).toBe(1)
