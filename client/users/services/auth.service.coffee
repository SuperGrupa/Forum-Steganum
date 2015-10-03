angular.module 'users'
.service 'authServ', ($meteor, $state) ->

  email: ''
  password: ''
  userName: ''
  error: ''

  goTo = ->
    if $state.previous.name then $state.go($state.previous) else $state.go('home')

  logIn: () ->
    $meteor.loginWithPassword(this.email, this.password).then (->
          goTo()
      ), (err) ->
          this.error = 'Login error - ' + err

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
        this.error = 'Register error - ' + err


