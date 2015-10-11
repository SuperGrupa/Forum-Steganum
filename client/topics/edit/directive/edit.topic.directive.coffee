angular.module 'topics'
.directive 'editTopic', ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/edit/directive/edit.topic.directive.html'
    controllerAs: 'edit'
    controller: (topicsServ, $stateParams) ->
        vm = this

        vm.section =
            name: ''

        topicsServ.getTopicById($stateParams.topic_id).then (result) ->
            vm.topic = result

        vm.section.name = topicsServ.getSectionTitle($stateParams.section_id)

        return vm
