liveEdit = ->
  restrict: 'AE'
  replace: true
  scope:
    field: '='
    onSave: '&'
    inputType: '@'
  templateUrl: 'client/common/directives/liveEdit/liveEdit.directive.html'

  link: (scope, elem, attrs) ->
    scope.save = ->
      reverseEditEnabled()
      scope.onSave()

    scope.startEditing = ->
      reverseEditEnabled()
      scope.focusInput = true

    reverseEditEnabled = ->
      scope.editEnabled = !scope.editEnabled

angular.module 'common'
.directive 'liveEdit', liveEdit
