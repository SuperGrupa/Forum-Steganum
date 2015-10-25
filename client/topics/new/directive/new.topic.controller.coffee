newTopicController = (topicsServ, sectionsServ, $stateParams) ->
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

newTopicController.$inject = ['topicsServ', 'sectionsServ', '$stateParams']

angular.module('topics')
.controller 'newTopicController', newTopicController
