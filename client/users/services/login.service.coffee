loginServ = ($meteor, $state) ->

  error = {
    login: ''
    register: ''
  }

  email: ''
  password: ''
  userName: ''
  error: error

  logIn: () ->
    $meteor.loginWithPassword(this.email, this.password).then (->
      $state.goBack()
    ), (err) ->
      error.login = 'Login error - ' + err

  logout: () ->
    $meteor.logout()
    $state.go('home')

  register: () ->
    credentials =
      email: this.email
      password: this.password
      username: this.userName

    $meteor.createUser(credentials).then (->
      $state.goBack()
    ), (err) ->
      error.register = 'Register error - ' + err


loginServ.$inject = ['$meteor', '$state']

angular.module 'users'
.service 'loginServ', loginServ
