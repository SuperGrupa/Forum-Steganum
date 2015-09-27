angular.module 'sections', ['ui.router']

.config ($stateProvider) ->
    $stateProvider.state 'sections',
        parent: 'root.main'
        url: '/sections'
        templateUrl: 'client/sections/sections.html'
        controller: 'SectionCtrl'
        controllerAs: 'sectionCtrl'
