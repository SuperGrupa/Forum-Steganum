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
