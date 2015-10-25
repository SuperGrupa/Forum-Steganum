TopicsCtrl = (topicsServ) ->
    vm = this
    vm.topic = topicsServ
    return vm

TopicsCtrl.$inject = ['topicsServ']

angular.module('topics')
.controller 'TopicsCtrl', TopicsCtrl
