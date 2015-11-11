describe 'App dependencies', ->
  module = null
  deps = null
  hasModule = (m) ->
    deps.indexOf(m) >= 0

  beforeEach ->
    module = angular.module('forumSteganum')
    deps = module.value('forumSteganum').requires

  it 'should be registered', ->
    expect(module).not.toEqual(null)

  it 'should have angular-meteor as a dependency', ->
    expect(hasModule('angular-meteor')).toEqual(true)

  it 'should have ui.router as a dependency', ->
    expect(hasModule('ui.router')).toEqual(true)

  it 'should have common as a dependency', ->
    expect(hasModule('common')).toEqual(true)

  it 'should have home as a dependency', ->
    expect(hasModule('home')).toEqual(true)

  it 'should have sections as a dependency', ->
    expect(hasModule('sections')).toEqual(true)

  it 'should have topics as a dependency', ->
    expect(hasModule('topics')).toEqual(true)

  it 'should have posts as a dependency', ->
    expect(hasModule('posts')).toEqual(true)

  it 'should have users as a dependency', ->
    expect(hasModule('users')).toEqual(true)
