angular.module 'forumSteganum'

.run ($rootScope, $state) ->
    $state.goBack = ->
      if $state.previous.name then $state.go($state.previous, $state.previousParams) else $state.go('home')

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
        if (fromState.name != 'login' && fromState.name != 'register')
            $state.previous = fromState
            $state.previousParams = fromParams
