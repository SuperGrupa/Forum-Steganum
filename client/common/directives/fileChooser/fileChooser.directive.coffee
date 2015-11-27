fileChooser = ->
    restrict: 'AE'
    replace: true
    templateUrl: 'client/common/directives/fileChooser/fileChooser.directive.html'
    scope:
        files: '='
    link: (scope, element, attrs) ->
        element.on 'change', (event) ->
            scope.files = event.target.files
            scope.fileName = _.first(scope.files).name
            scope.$apply()

        scope.removeFile = ->
            scope.files = []
            scope.fileName = ''

angular.module 'common'
.directive 'fileChooser', fileChooser
