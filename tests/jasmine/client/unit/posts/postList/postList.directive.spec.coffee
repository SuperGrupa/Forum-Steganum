'use strict'

describe 'Directive: postList', ->
  beforeEach module 'forumSteganum'
  compile = {}
  rootScope = {}
  element = {}
  scope = {}
  $timeout = {}

  beforeEach ->
    inject (_$compile_, _$rootScope_, _$timeout_) ->
      $timeout = _$timeout_
      compile = _$compile_
      rootScope = _$rootScope_
      scope = rootScope
      scope.posts = ['post1', 'post2']
      element = angular.element('<posts-list posts="posts"></posts-list>')
      compile(element)(scope)
      angular.element(document.body).append(element)
      scope.$digest()

  describe 'input', ->
    it 'should be focused when atrr variable is true', ->
      expect(element.scope.posts).toBe scope.posts

    it 'should be focused when atrr variable is true', ->
      expect(element.scope.posts).toBe scope.posts
