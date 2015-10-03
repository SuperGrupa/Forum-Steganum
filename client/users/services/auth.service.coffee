angular.module 'users'
.service 'authServ', ($meteor, $state) ->

  email: ''
  password: ''
  userName: ''
  error: ''

  logIn: () ->
    $meteor.loginWithPassword(this.email, this.password).then (->
          if $state.previous.name then $state.go($state.previous) else $state.go('home')
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
      if $state.previous.name then $state.go($state.previous) else $state.go('home')
    ), (err) ->
        this.error = 'Register error - ' + err


