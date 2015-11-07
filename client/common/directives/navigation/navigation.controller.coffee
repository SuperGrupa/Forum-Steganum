navigationController = ($meteor) ->
    vm = this

    if !!vm.sectionId
        $meteor.call('getSectionById', vm.sectionId).then ->
            vm.section = Filter.Sections.by(vm.sectionId)

    if !!vm.topicId
        $meteor.call('getTopicById', vm.topicId).then ->
            vm.topic = Filter.Topics.by.id(vm.topicId)

    return vm

navigationController.$inject = ['$meteor']

angular.module('common')
.controller 'navigationController', navigationController
