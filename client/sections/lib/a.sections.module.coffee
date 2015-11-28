resolveObject = (what, name) ->
    'isLogged': ['authServ', (authServ) ->
        authServ.isLogged()]
    'userCan': ['authServ', (authServ) ->
        authServ.stateCan(what, name)]

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
    ).state('section.new',
        url: '/new'
        templateUrl: 'client/sections/new/new.section.html'
        resolve: resolveObject('create', 'section')
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
        resolve: resolveObject('read', 'section')
    ).state('section.one.delete',
        url: '/delete'
        templateUrl: 'client/sections/delete/delete.section.html'
        controller: 'DeleteSectionCtrl'
        controllerAs: 'delSecCtrl'
        resolve: resolveObject('remove', 'section')
    ).state('section.one.edit',
        url: '/edit'
        templateUrl: 'client/sections/edit/edit.section.html'
        controller: 'EditSectionCtrl'
        controllerAs: 'edit'
        resolve: resolveObject('update', 'section')
    )
    return

sectionsModule.$inject = ['$stateProvider']

angular.module 'sections', ['ui.router']
.config sectionsModule
