postsListController = (postsServ) ->
    vm = this
    vm.post = postsServ
    return vm

postsListController.$inject = ['postsServ']

angular.module('posts')
.controller 'postsListController', postsListController
