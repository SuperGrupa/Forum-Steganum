fileChooser = ->
    restrict: 'AE'
    replace: true
    templateUrl: 'client/common/directives/fileChooser/fileChooser.directive.html'
    scope:
        files: '='

    link: (scope, element, attrs) ->
        input = element.find('.file-input')
        button = element.find('.upload-button')

        if (input.length && button.length)
            button.click((e) -> input.click())

        input.on 'change', (event) ->
            scope.files = event.target.files

angular.module 'common'
.directive 'fileChooser', fileChooser
