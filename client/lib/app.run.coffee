angular.module 'forumSteganum'

.run ($rootScope, $state) ->
    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState) ->
        $state.previous = fromState
