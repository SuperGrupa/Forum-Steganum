alertsServ = (toastr) ->
    messages =
        notLogged: 'You are not logged in'
        notAuthorized: 'You are not authorized to do this action'
        emptyPostNotAllowed: 'Empty posts are not allowed!'

    getMessage = (data) ->
        return messages[data.error]

    success: (title, message) ->
        toastr.success(message, title)

    error: (error) ->
        toastr.error(getMessage(error), 'Error')

alertsServ.$inject = ['toastr']

angular.module 'common'
.service 'alertsServ', alertsServ
