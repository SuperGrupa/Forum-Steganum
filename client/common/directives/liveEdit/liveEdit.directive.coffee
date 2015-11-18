liveEdit = ->
    restrict: 'AE'
    replace: true
    scope: true
    bindToController:
        object: '='
        onSave: '&'
        inputType: '@'
    templateUrl: 'client/common/directives/liveEdit/liveEdit.directive.html'
    controllerAs: 'live'
    controller: () ->
        vm = this
        vm.object = angular.copy vm.object

        vm.save = ->
            vm.reverseEditEnabled()
            vm.onSave(vm.object)

        vm.startEditing = ->
            vm.reverseEditEnabled()
            vm.focusInput = true

        vm.reverseEditEnabled = ->
            vm.editEnabled = !vm.editEnabled

        return vm

angular.module 'common'
.directive 'liveEdit', liveEdit
