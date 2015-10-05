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

        topicsServ.getSectionTitle($stateParams.topic_id).then (result) ->
            vm.section.name = result

        return vm
