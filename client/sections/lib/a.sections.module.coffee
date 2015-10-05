angular.module 'sections', ['ui.router']

.config ($stateProvider) ->
    $stateProvider.state('section',
        url: '/section'
        parent: 'root.main'
        abstract: true
        templateUrl: 'client/sections/sections.html'
        controller: 'SectionCtrl'
        controllerAs: 'sectionCtrl'
    ).state('section.list',
        url: 's'
        templateUrl: 'client/sections/list/list.sections.html'
    ).state('section.one',
        # ten stan jest abstrakcyjny, ponieważ jego potomkiem jest oprócz section.one.show także
        # topic i topic.new w module topics
        url: '/:section_id'
        abstract: true
        templateUrl: 'client/sections/sections.html'
    ).state('section.one.show',
        url: ''
        templateUrl: 'client/sections/show/show.section.html'
        controller: 'ShowSectionCtrl'
        controllerAs: 'showSectionCtrl'
    )
