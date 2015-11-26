module.exports = (config) ->
  config.set
    basePath: '../../'
    frameworks: ['jasmine']

    # list of files / patterns to load in the browser
    files: [
      '../.gulp/www/js/vendor.js'
      '../.gulp/components/angular-mocks/angular-mocks.js'

      '../.gulp/www/templates/**/*.html'

      'client/mocks/**/mocks.coffee'
      'client/unit/tests.helper.js'

      '../client/lib/*.coffee'
      '../client/**/lib/*.coffee'
      '../client/**/*.coffee'


      'client/unit/app/helpers/**/*.coffee'
      'client/unit/**/*.coffee'
    ]

    exclude: [
      'karma.config.coffee'
      '../client/app.config.coffee'
    ]

    autoWatch: true

    # f.e. Chrome, PhantomJS
    browsers: ['PhantomJS']

    reporters: ['progress', 'coverage']

    coverageReporter:
      type : 'lcov'
      dir : 'coverage'
      subdir: (browser, platform) ->
        browser.toLowerCase().split(' ')[0]

    preprocessors:
      '../client/**/*.coffee': ['coverage']
      'client/unit/**/*.coffee': ['coffee']
      'client/mocks/**/mocks.coffee': ['coffee']
      '../.gulp/www/templates/**/*.html': ['ng-html2js']

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: true

    ngHtml2JsPreprocessor:
      moduleName: 'templates'
      stripPrefix: '.*/www/templates'
      prependPrefix: 'client'

    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true
