appRun = ($rootScope, $state, authServ) ->
    $rootScope.can = authServ.can

    $state.goBack = ->
        if $state.previous.name then $state.go($state.previous, $state.previousParams) else $state.go('home')

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
        switch error
            when 'AUTH_REQUIRED' then $state.go('login')
            when 'UNAUTHORIZED' then $state.go('error', { code: 401, text: 'Unauthorized' })
            when 'ALREADYLOGGED' then $state.go('home')
            else $state.go('error')

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams, error) ->
        if (fromState.name != 'login' && fromState.name != 'register')
            $state.previous = fromState
            $state.previousParams = fromParams
    return

appRun.$inject = ['$rootScope', '$state', 'authServ']

angular.module 'forumSteganum'
.run appRun
