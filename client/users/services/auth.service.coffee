angular.module 'users'
.service 'authServ', ($meteor, $state) ->

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

  register: () ->
    credentials =
      email: this.email
      password: this.password
      username: this.userName

    $meteor.createUser(credentials).then (->
      $state.goBack()
    ), (err) ->
      error.register = 'Register error - ' + err
