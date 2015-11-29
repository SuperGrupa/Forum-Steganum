'use strict'

describe 'Directive: file-chooser', ->
    file =
        name: 'tush.png'

    beforeEach module 'common'
    beforeEach module 'templates'

    element = {}

    compileElement = (files) ->
        element = new TestElement 'file-chooser'
        element.create '<file-chooser file="file"></file-chooser>',
            file: file

    describe 'binding files after compile', ->
        beforeEach (done) ->
            compileElement(file)
            done()

        it 'should bind element scope file to file', () ->
            expect(element.scope.file).toEqual(file)

        it 'shouldn\'t have button to delete image file', ->
            expect(element.dom.find('md-icon.delete').length).toBe(0)

     describe 'scope.removeFile function', ->
         beforeEach ->
             element.scope.removeFile()

         it 'should assign object with name: \'\' to scope.file', ->
             expect(element.scope.file).toEqual
                name: ''

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
             expect(element.scope.file).toEqual
                name: 'LaGrange.png'
