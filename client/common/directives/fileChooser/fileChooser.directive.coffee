fileChooser = ->
    restrict: 'AE'
    replace: true
    templateUrl: 'client/common/directives/fileChooser/fileChooser.directive.html'
    scope:
        file: '='
    link: (scope, element, attrs) ->
        scope.changeFile = (event) ->
            firstFile = _.first(event.target.files)
            if firstFile? && firstFile.name?
                scope.file = firstFile
                scope.$apply()

        scope.removeFile = ->
            scope.file =
                name: ''

        element.on 'change', scope.changeFile

angular.module 'common'
.directive 'fileChooser', fileChooser
