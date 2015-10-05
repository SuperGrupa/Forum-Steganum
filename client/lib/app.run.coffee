angular.module 'forumSteganum'

.run ($rootScope, $state) ->
    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState) ->
        if (fromState.name != 'login' && fromState.name != 'register')
            $state.previous = fromState
