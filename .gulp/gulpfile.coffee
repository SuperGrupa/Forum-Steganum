Q                   = require 'q'
child_process       = require 'child_process'
gulp                = require 'gulp'
gutil               = require 'gulp-util'
less                = require 'gulp-less'
coffee              = require 'gulp-coffee'
jade                = require 'gulp-jade'
livereload          = require 'gulp-livereload'
changed             = require 'gulp-changed'
open                = require 'open'
http                = require 'http'
path                = require 'path'
ecstatic            = require 'ecstatic'
notify              = require 'gulp-notify'
concat              = require 'gulp-concat'
clean               = require 'gulp-clean'
cache               = require 'gulp-cache'
protractor          = require 'gulp-protractor'
rename              = require 'gulp-rename'
runSequence         = require 'run-sequence'
argv                = require('yargs').argv
fs                  = require 'fs'
ngConstant          = require 'gulp-ng-constant'
webdriverStandalone = require('gulp-protractor').webdriver_standalone
webdriverUpdate     = require('gulp-protractor').webdriver_update
karma               = require('karma').server
connect             = require('gulp-connect')
rename              = require("gulp-rename");

# configs
karmaConfig         = require('../tests/client/unit/karma.config')
protractorConfig    = require('../tests/client/e2e/protractor.config')

paths =
  public: ['public/**']
  assets: ['assets/**']
  styles: [
    '../client/**/*.less'
    'components/angular-material/angular-material.css'
  ]
  img: [
    '../public/images/**/*.*'
  ]
  fonts: [
    '../public/fonts/**/*.*'
  ]
  scripts:
    vendor: [
      'components/angular/angular.js'
      'components/angular-animate/angular-animate.js'
      'components/angular-aria/angular-aria.js'
      'components/angular-material/angular-material.js'
      'components/angular-ui-router/release/angular-ui-router.js'
    ]
    app: [
      '../client/lib/*.coffee'
      '../client/app.config.coffee'
      '../client/**/*.coffee'
    ]
    tests: [
      '../tests/client/unit/**/*.coffee'
    ]
    e2etests: [
      '../tests/client/e2e/**/*.scenario.coffee'
    ]
  templates: ['../client/**/*.jade']

destinations =
  public: 'www'
  styles: 'www/css'
  scripts: 'www/js'
  templates: 'www/templates'
  livereload: ['www/**']
  fonts: 'www/fonts'
  img: 'www/img'
  assets: 'www'
  config: 'config/'

options =
  open: false # open the server in the browser on init?
  httpPort: process.env.PORT || 4400

#globals visible in templates
globals = switch gutil.env.env
  when 'production'
    ENV_NAME: 'production'
    BACKEND_URL: process.env.BACKEND_URL || 'http://hubeert.pl'
  else
    ENV_NAME: 'development'
    BACKEND_URL: process.env.BACKEND_URL || 'http://localhost:3000'
    DIST_DIR: 'www'

# You can replace one of globals by devining ENV variable,
# f.e. `BACKEND_URL='http://192.168.0.666:1337' gulp`
for k, v of globals
  globals[k] = process.env[k] if process.env[k]?

gulp.task 'clean', ->
  gulp.src('www', read: false)
    .pipe(clean())

gulp.task('webdriver:update', webdriverUpdate)

gulp.task 'public', ->
  gulp.src(paths.public)
    .pipe(changed(destinations.public))
    .pipe(gulp.dest(destinations.public))

gulp.task 'styles', ->
  gulp.src(paths.styles)
    .pipe(changed(destinations.styles, extension: '.css'))
    .pipe(less())
    .on('error', notify.onError((error) -> error.message))
    .pipe(gulp.dest(destinations.styles))

gulp.task 'fonts', ->
  gulp.src(paths.fonts)
    .pipe(changed(destinations.fonts))
    .pipe(gulp.dest(destinations.fonts))

gulp.task 'img', ->
  gulp.src(paths.img)
    .pipe(changed(destinations.img))
    .pipe(gulp.dest(destinations.img))

gulp.task 'assets', ->
  gulp.src(paths.assets)
    .pipe(changed(destinations.assets))
    .pipe(gulp.dest(destinations.assets))

gulp.task 'scripts:vendor', ->
  gulp.src(paths.scripts.vendor)
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest(destinations.scripts))

gulp.task 'scripts:app', ->
  gulp.src(paths.scripts.app)
    .pipe(coffee({
      sourceMap: false
    }))
    .on('error', notify.onError((error) -> error.message))
    .pipe(concat('app.js'))
    .pipe(gulp.dest(destinations.scripts))

gulp.task 'scripts', ['scripts:vendor', 'scripts:app']

gulp.task 'templates', ->
  gulp.src(paths.templates)
    .pipe(rename( (path) ->
      if (path.basename != "index")
        path.basename = path.basename.substring(0, path.basename.length - 3);;
      path.extname = ".html"
    ))
    .pipe(jade({
      locals:
        GLOBALS: globals
      pretty: true
    }))
    .on('error', notify.onError((error) -> error.message))
    .pipe(gulp.dest(destinations.templates))

gulp.task 'index', ->
  gulp.src(destinations.templates + '/index.html')
  .pipe(gulp.dest(destinations.public))

phantomChild = null
phantomDefer = null

# standalone test server which runs in the background.
# doesnt work atm - instead, run `webdriver-manager start`
gulp.task 'test:e2e:server', (cb) ->
  return cb() if phantomDefer
  phantomDefer = Q.defer()

  phantomChild = child_process.spawn('phantomjs', ['--webdriver=4444'], {
  })
  phantomChild.stdout.on 'data', (data) ->
    gutil.log gutil.colors.yellow data.toString()
    if data.toString().match 'running on port '
      phantomDefer.resolve()
    
  phantomChild.once 'close', ->
    gutil.log "phantomChild closed"
    phantomChild.kill() if phantomChild
    phantomDefer.reject()

  phantomChild.on 'exit', (code) ->
    gutil.log "phantomChild exitted"
    phantomChild.kill() if phantomChild

  phantomDefer.promise

# You can run it like this:
# `gulp test:e2e` - runs all e2e tests
# `gulp test:e2e --debug --specs tests/map_test.coffee` - runs only one test, in debug mode
gulp.task 'test:e2e', [], ->
  args = ['--baseUrl', "http://localhost:#{options.httpPort}"]
  args.push 'debug' if argv.debug

  protractorTests = paths.scripts.e2etests
  protractorTests = gulp.env.specs.split(',') if gulp.env.specs

  gulp.src(protractorTests)
    .pipe(protractor.protractor({
      configFile: "test/e2e/protractor.config.js",
      args: args
    }))
    .on('error', (notify.onError((error) -> error.message)))

# Runs unit tests using karma.
# You can run it simply using `gulp test:unit`.
# You can also pass some karma arguments like this: `gulp test:unit --browsers Chrome`.
gulp.task 'test:unit', (cb) ->
  args = ['start', '../tests/client/unit/karma.config.coffee']
  for name in ['browsers', 'reporters']
    args.push "--#{name}", "#{gutil.env[name]}" if gutil.env.hasOwnProperty(name)

  child = child_process.spawn "node_modules/.bin/karma", args,
    stdio: 'inherit'
  .on 'exit', (code) ->
    child.kill() if child
    cb(code)

gulp.task 'watch', ->
  gulp.watch(paths.public, ['public'])
  gulp.watch(paths.scripts.app, ['scripts:app'])
  gulp.watch(paths.scripts.vendor, ['scripts:vendor'])
  gulp.watch(paths.assets, ['assets'])
  gulp.watch(paths.styles, ['styles'])
  gulp.watch(paths.fonts, ['fonts'])
  gulp.watch(paths.img, ['img'])
  gulp.watch(paths.templates, ['templates'])

  livereloadServer = livereload()
  livereload.listen()
  gulp.watch(destinations.livereload).on('change', livereload.changed)

gulp.task 'server', ->
  connect.server({
    root: 'www',
    port: options.httpPort,
    fallback: 'www/index.html',
    livereload: false
  });
  gutil.log gutil.colors.blue "HTTP server listening on #{options.httpPort}"
  if options.open
    url = "http://localhost:#{options.httpPort}/"
    open(url)
    gutil.log gutil.colors.blue "Opening #{url} in the browser..."

gulp.task 'build', (cb) ->
  runSequence 'clean',
    [
      'public'
      'styles'
      'fonts'
      'img'
      'scripts'
      'assets'
      'templates'
    ],
    'index'
    , cb

gulp.task 'default', (cb) ->
  runSequence 'build', ['watch', 'server'], cb
