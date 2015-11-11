editTopic = ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/topics/edit/directive/edit.topic.directive.html'
    controllerAs: 'edit'
    controller: 'editTopicController'


angular.module 'topics'
.directive 'editTopic', editTopic
