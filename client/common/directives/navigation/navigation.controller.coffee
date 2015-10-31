navigationController = ($meteor) ->
    vm = this

    if vm.sectionId?
        $meteor.call('getSectionById', vm.sectionId).then ->
            # TODO użyć filtrów kiedy zmerguje się ich gałąź
            vm.section = Sections.findOne({ _id: vm.sectionId })

    if vm.topicId?
        $meteor.call('getTopicById', vm.topicId).then ->
            # TODO użyć filtrów kiedy zmerguje się ich gałąź
            vm.topic   = Topics.findOne(id: vm.topicId)

    return vm

navigationController.$inject = ['$meteor']

angular.module('common')
.controller 'navigationController', navigationController
