angular.module 'users'
.service 'authServ', ($meteor, $state) ->

  error = {
    login: ''
    register: ''
  }

  goTo = ->
    if $state.previous.name then $state.go($state.previous) else $state.go('home')

  errors: () ->
    error

  email: ''
  password: ''
  userName: ''
  error: error

  logIn: () ->
    $meteor.loginWithPassword(this.email, this.password).then (->
      goTo()
    ), (err) ->
      error.login = 'Login error - ' + err

  logout: () ->
    $meteor.logout().then ->
      $state.go 'home'

  register: () ->
    credentials =
      email: this.email
      password: this.password
      username: this.userName

    $meteor.createUser(credentials).then (->
      goTo()
    ), (err) ->
      error.register = 'Register error - ' + err


