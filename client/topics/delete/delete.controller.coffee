angular.module('topics')
.controller 'DeleteTopicsCtrl', ($stateParams) ->
    vm = this
    vm.topic =
        id: $stateParams.topic_id

    return vm
