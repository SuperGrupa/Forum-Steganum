child_process       = require 'child_process'
gulp                = require 'gulp'
gutil               = require 'gulp-util'
coffee              = require 'gulp-coffee'
jade                = require 'gulp-jade'
path                = require 'path'
notify              = require 'gulp-notify'
concat              = require 'gulp-concat'
clean               = require 'gulp-clean'
rename              = require 'gulp-rename'
runSequence         = require 'run-sequence'
uglify              = require 'gulp-uglify'
fs                  = require 'fs'

paths =
  scripts:
    vendor: [
      'components/jquery/dist/jquery.js'
      'components/angular/angular.js'
      'components/angular-animate/angular-animate.js'
      'components/angular-aria/angular-aria.js'
      'components/angular-material/angular-material.js'
      'components/angular-ui-router/release/angular-ui-router.js'
      'components/underscore/underscore-min.js'
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
  scripts: 'www/js'
  templates: 'www/templates'

gulp.task 'clean', ->
  gulp.src('www', read: false)
    .pipe(clean())

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
        path.basename = path.basename.substring(0, path.basename.length - 3)
      path.extname = ".html"
    ))
    .pipe(jade({
      pretty: true
    }))
    .on('error', notify.onError((error) -> error.message))
    .pipe(gulp.dest(destinations.templates))


tests = (cb, singleRun) ->
  args = ['start', '../tests/client/unit/karma.config.coffee']
  args.push "--singleRun", singleRun.toString()

  child = child_process.spawn "node_modules/.bin/karma", args,
    stdio: 'inherit'
  .on 'exit', (code) ->
    child.kill() if child
    cb(code)

gulp.task 'unit-tests', (cb) ->
  tests(cb, true)
  cb

gulp.task 'ut', (cb) ->
  tests(cb, false)
  cb

gulp.task 'build', (cb) ->
  runSequence 'clean',
    [
      'scripts'
      'templates',
      'build-algorithm'
    ],
    cb

gulp.task 'default', (cb) ->
  runSequence 'build', 'unit-tests', cb

gulp.task 'dev', (cb) ->
  runSequence 'build', 'ut', cb

gulp.task 'build-algorithm', () ->
    gulp.src(['../.steganography/js/*/*.js', '../.steganography/js/*.js'])
        .pipe(concat('build.min.js'))
        .pipe uglify mangle: sort: true
        .pipe(gulp.dest('algorithm'))

    content  = '
        module.exports "algorithm",
            content: """'
    content += fs.readFileSync('algorithm/build.min.js')
    content += '"""'

    fs.writeFile('../server/steganography/algorithm.coffee', content)
