angular.module 'sections', ['ui.router']

.config ($stateProvider) ->
    $stateProvider.state('section',
        url: '/section'
        parent: 'root.main'
        abstract: true
        templateUrl: 'client/sections/sections.html'
    ).state('section.list',
        url: 's'
        templateUrl: 'client/sections/list/list.sections.html'
        controller: 'ListSectionsCtrl'
        controllerAs: 'listSectionsCtrl'
    ).state('section.show',
        url: '/:id'
        templateUrl: 'client/sections/show/show.section.html'
        controller: 'ShowSectionCtrl'
        controllerAs: 'showSectionCtrl'
    )
