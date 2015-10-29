editTopicController = (topicsServ, sectionsServ, $state, $stateParams) ->
    vm = this
    vm.state = $state
    vm.section =
        name: ''

    topicsServ.getTopicById($stateParams.topic_id).then (result) ->
        vm.topic = result

    sectionsServ.getSectionById($stateParams.section_id).then (result) ->
        vm.section = result

    return vm

editTopicController.$inject = ['topicsServ', 'sectionsServ', '$state', '$stateParams']

angular.module('topics')
.controller 'editTopicController', editTopicController
