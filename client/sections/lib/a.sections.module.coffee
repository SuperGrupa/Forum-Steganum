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
        controller: 'SectionCtrl'
        controllerAs: 'sectionCtrl'
    ).state('section.show',
        url: '/:id'
        templateUrl: 'client/sections/show/show.section.html'
    )
