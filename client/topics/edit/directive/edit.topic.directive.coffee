angular.module 'topics'
.directive 'editTopic', ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/edit/directive/edit.topic.directive.html'
    controllerAs: 'edit'
    controller: (topicsServ, sectionsServ, $state, $stateParams) ->
        vm = this
        vm.state = $state
        vm.section =
            name: ''

        topicsServ.getTopicById($stateParams.topic_id).then (result) ->
            vm.topic = result

        sectionsServ.getSectionById($stateParams.section_id).then (result) ->
            vm.section = result

        return vm
