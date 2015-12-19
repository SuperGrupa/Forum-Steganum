'use strict'

describe 'Directive: roleCan', ->
    role =
        can:
            create:
                post: true
                topic: false
                section: false
                self:
                    post: true
                    topic: true
                    section: true

    beforeEach module 'admin'
    beforeEach module 'templates'
    beforeEach module 'ngMaterial'

    element = {}

    compileElement = () ->
        element = new TestElement()
        element.createDirective 'roleCan', '<role-can role="role" property="create"></role-can>',
            role: role

    beforeEach (done) ->
        compileElement()
        done()

    it 'should compile', () ->
        expect(element.dom).toBeTruthy()

    describe 'binding', ->
        it 'should bind role to ctrl and scope', () ->
            expect(element.ctrl.role).toBe role
            expect(element.scope.vm.role).toBe role

        it 'should bind property to ctrl and scope', () ->
            expect(element.ctrl.property).toBe 'create'
            expect(element.scope.vm.property).toBe 'create'

        describe 'roleModified method', ->
            beforeEach (done) ->
                element.ctrl.roleModified(role)
                done()

            it 'should add updated and selected properties to role with true as a value', () ->
                expect(role.updated).toBe true
                expect(role.selected).toBe true
