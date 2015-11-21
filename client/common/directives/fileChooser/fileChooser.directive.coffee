fileChooser = ->
    restrict: 'AE'
    replace: true
    templateUrl: 'client/common/directives/fileChooser/fileChooser.directive.html'

    link: (scope, element, attrs) ->
        input = element.find('.file-input')
        button = element.find('.upload-button')

        if (input.length && button.length)
            button.click((e) -> input.click())

angular.module 'common'
.directive 'fileChooser', fileChooser
