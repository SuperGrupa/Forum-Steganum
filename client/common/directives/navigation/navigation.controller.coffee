navigationController = ($meteor) ->
    vm = this

    if !!vm.sectionId
        $meteor.call('getSectionById', vm.sectionId).then (result) ->
            vm.section = result

    if !!vm.topicId
        $meteor.call('getTopicById', vm.topicId).then (result) ->
            vm.topic = result

    return vm

navigationController.$inject = ['$meteor']

angular.module('common')
.controller 'navigationController', navigationController
