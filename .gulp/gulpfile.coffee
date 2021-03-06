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
argv                = require('yargs').argv
protractor          = require('gulp-angular-protractor')

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
      '../tests/e2e/**/*.scenario.coffee'
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

gulp.task 'e2e', ->
  args = undefined
  protractorTests = undefined
  gutil.log gutil.colors.blue('Starting e2e test')
  baseURL = ''
  if !!argv.port
    baseURL = 'http://localhost:' + argv.port
  else
    baseURL = 'http://localhost:50560'
  args = [
    '--baseUrl'
    baseURL
  ]
  if !!argv.debug
    args.push 'debug'
  protractorTests = paths.scripts.e2etests
  # --specs='path to specs'
  if !!argv.specs
    protractorTests = argv.specs.split(',')
  gulp.src(protractorTests).pipe protractor(
    configFile: '../tests/e2e/protractor.config.js'
    args: args)
  return


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
      'algorithm-build'
    ],
    cb

gulp.task 'default', (cb) ->
  runSequence 'build', 'unit-tests', cb

gulp.task 'dev', (cb) ->
  runSequence 'build', 'ut', cb

gulp.task 'algorithm-minify', () ->
    return gulp.src(['../.stegano/js/lib/*.js', '../.stegano/js/**/common.js', '../.stegano/js/**/*.js'])
        .pipe(concat('build.min.js'))
        .pipe(gulp.dest('algorithm/original'))
        .pipe uglify mangle: sort: true
        .pipe(gulp.dest('algorithm'))

gulp.task 'algorithm-minify-dev', () ->
    return gulp.src(['../.stegano/js/lib/*.js', '../.stegano/js/**/common.js', '../.stegano/js/**/*.js'])
        .pipe(concat('build.min.js'))
        .pipe(gulp.dest('algorithm'))

gulp.task 'algorithm-move-to-server', () ->
    content  = '
        module.exports "algorithm",
            content: """'
    content += fs.readFileSync(__dirname + '/algorithm/build.min.js')
    content += 'stegano.run();"""'

    return fs.writeFile(__dirname + '/../server/steganography/algorithm.coffee', content)

gulp.task 'algorithm-build', (cb) ->
    runSequence 'algorithm-minify', 'algorithm-move-to-server', cb
