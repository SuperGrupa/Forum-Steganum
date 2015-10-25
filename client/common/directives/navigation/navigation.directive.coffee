angular.module 'common'
.directive 'navigation', ->
    restrict: 'AE'
    scope:
        sectionId: '@'
        topicId: '@'
    bindToController: true
    templateUrl: 'client/common/directives/navigation/navigation.directive.html'
    controllerAs: 'nav'
    controller: ($meteor) ->
        vm = this

        if vm.sectionId?
            $meteor.call('getSectionById', vm.sectionId).then ->
                # TODO użyć filtrów kiedy zmerguje się ich gałąź
                vm.section = Sections.findOne({ _id: vm.sectionId })

        if vm.topicId?
            $meteor.call('getTopicById', vm.topicId).then ->
                # TODO użyć filtrów kiedy zmerguje się ich gałąź
                vm.topic   = Topics.findOne(_id: vm.topicId)

        return vm
