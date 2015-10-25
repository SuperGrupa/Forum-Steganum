newTopic = ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/new/directive/new.topic.directive.html'
    controllerAs: 'new'
    controller: 'newTopicController'

angular.module 'topics'
.directive 'newTopic', newTopic
