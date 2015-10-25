sectionsModule = ($stateProvider) ->
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
    ).state('section.one.delete',
        url: '/delete'
        templateUrl: 'client/sections/delete/delete.section.html'
        controller: 'DeleteSectionCtrl'
        controllerAs: 'delSecCtrl'
    ).state('section.one.edit',
        url: '/edit'
        templateUrl: 'client/sections/edit/edit.section.html'
        controller: 'EditSectionCtrl'
        controllerAs: 'edit'
    )
    return

sectionsModule.$inject = ['$stateProvider']

angular.module 'sections', ['ui.router']
.config sectionsModule
