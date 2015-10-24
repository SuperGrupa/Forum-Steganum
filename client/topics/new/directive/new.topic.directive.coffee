newTopic = ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/new/directive/new.topic.directive.html'
    controllerAs: 'new'
    controller: (topicsServ, sectionsServ, $stateParams) ->
        vm = this

        vm.section =
            name: ''

        vm.topic =
            section_id: $stateParams.section_id
            name: ''
            description: ''

        sectionsServ.getSectionById(vm.topic.section_id).then (result) ->
            vm.section.name = result.name

        return vm

angular.module 'topics'
.directive 'newTopic', newTopic
