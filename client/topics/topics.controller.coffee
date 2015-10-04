angular.module('topics')
.controller 'TopicsCtrl', (topicsServ) ->
    vm = this
    vm.topic = topicsServ
    return vm
