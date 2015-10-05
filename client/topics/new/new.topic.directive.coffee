angular.module 'topics'
.directive 'newTopic', ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/new/new.topic.directive.html'
    controllerAs: 'new'
    controller: (topicsServ, $stateParams) ->
        vm = this

        vm.section =
            name: ''

        vm.topic =
            section_id: $stateParams.section_id
            name: ''
            description: ''

        topicsServ.getSectionTitle(vm.topic.section_id).then (result) ->
            vm.section.name = result

        return vm
