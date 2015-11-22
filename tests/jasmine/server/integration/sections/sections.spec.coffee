Helpers = require 'Helpers'

describe 'Sections', ->
    section =
        name: 'Example section name'
        description: 'Description of example section'

    # TODO ta metoda jest jeszcze nieużywana w kliencie
    describe 'addSection method', ->
        it 'should throw not-authorized exception for not logged user', ->
            Helpers.logout()
            Meteor.call 'addSection', section, (error) ->
                expect(error).toEqual(new Meteor.Error('notLogged'))

        it 'should add new section after login', ->
            Helpers.login('admin')
            sections_before = Sections.find({}).count()
            Meteor.call 'addSection', section
            expect(Sections.find({}).count()).toEqual(sections_before + 1)
            expect(Sections.find({ name: 'Example section name' }).count()).toBeGreaterThan(0)

    describe 'updateSection method', ->
        beforeEach ->
            Helpers.seed.section(section)
            Helpers.login('admin')

        it 'should update section name and description in database', ->
            local_section = Sections.findOne({ name: 'Example section name' })
            expect(local_section).not.toBe(undefined)

            local_section.name = 'Updated section name'
            local_section.description = 'Updated description of example section'

            Meteor.call 'updateSection', local_section

            updated_section = Sections.findOne({ id: local_section.id })
            expect(updated_section).not.toBe(undefined)
            expect(updated_section.name).toBe('Updated section name')
            expect(updated_section.description).toBe('Updated description of example section')

    describe 'deleteSection method', ->
        beforeEach ->
            Helpers.clear()
            Helpers.seed.section(section)
            Helpers.login('admin')

        it 'should delete given section', ->
            local_section = Sections.findOne({ name: 'Example section name' })
            expect(local_section).not.toBe(undefined)

            Meteor.call 'deleteSection', local_section.id

            local_section = Sections.findOne({ name: 'Example section name' })
            expect(local_section).toBe(undefined)

    describe 'getSectionById method', ->
        beforeEach ->
            Helpers.clear()
            Helpers.seed.section(section)
            Helpers.login('admin')

        it 'should return section object based on given id', ->
            section_from_db = Sections.findOne({ name: 'Example section name' })
            expect(section_from_db).not.toBe(undefined)

            section_from_method = Meteor.call 'getSectionById', section_from_db.id
            expect(section_from_db).toEqual(section_from_method)
