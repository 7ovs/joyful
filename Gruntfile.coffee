module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-sass")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-contrib-cssmin")
  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks("grunt-contrib-clean")
  grunt.loadNpmTasks("grunt-contrib-watch")


  APP_DIR = 'app'
  TMP_DIR = 'tmp'
  DEV_DIR = 'dev'
  DST_DIR = 'dst'
  BOWER   = 'bower_components'

  grunt.initConfig

    #=== COFFEE
    coffee:
      client:
        files:
          "#{TMP_DIR}/js/app.js": "#{APP_DIR}/scripts/app.coffee"

      server:
        options:
          bare: yes
        files:
          "#{DEV_DIR}/web.js": "#{APP_DIR}/app.coffee"


    #=== LESS
    less:
      app:
        options:
          paths: [
            "#{APP_DIR}/styles"
            "#{BOWER}/bootstrap/less"
          ]
        files:
          "#{DEV_DIR}/pub/app.css": "#{APP_DIR}/styles/app.less"

    #=== LESS
    sass:
      app:
        options:
          includePaths: [
            "#{APP_DIR}/styles"
            "#{BOWER}/uikit/scss"
          ]
        files:
          "#{DEV_DIR}/pub/app.css": "#{APP_DIR}/styles/app.sass"


    #=== CONCAT
    concat:

      core:
        src: [
          "#{BOWER}/jquery/dist/jquery.js"
          "#{BOWER}/lodash/dist/lodash.js"
          "#{BOWER}/moment/min/moment-with-locales.min.js"
          "#{BOWER}/uikit/js/uikit.min.js"
          "#{BOWER}/uikit/js/components/slideshow.min.js"
          "#{BOWER}/uikit/js/components/slideshow-fx.min.js"
          "#{BOWER}/uikit/js/components/slideset-fx.min.js"
        ]
        dest: "#{DEV_DIR}/pub/core.js"


      app:
        src: [
          "#{TMP_DIR}/js/app.js"
        ]
        dest: "#{DEV_DIR}/pub/app.js"


    copy:
      dev:
        files: [
            expand: yes
            cwd: "#{BOWER}/uikit/fonts/"
            src: "**"
            dest: "#{DEV_DIR}/pub/fonts"
          ,
            expand: yes
            src: ["package.json", "Procfile"]
            dest: "dev"
            filter: 'isFile'
        ]

      statics:
        files: [
          expand: yes
          cwd: "#{APP_DIR}/statics/"
          src: "**"
          dest: "#{DEV_DIR}/pub/"
        ]
      views:
        files: [
            expand: yes
            cwd: "#{APP_DIR}/views/"
            src: "**"
            dest: "#{DEV_DIR}/views"
        ]


    clean:
      dev: [
        "#{DEV_DIR}/**"
      ]
      temp: ["tmp"]
      pub: ["#{DEV_DIR}/pub/**", "#{DEV_DIR}/views/**"]

    watch:
      sass:
        files: ["#{APP_DIR}/styles/*.sass"]
        tasks: ["sass"]
        options:
          spawn: no
          livereload: yes

      coffee_client:
        files: ["#{APP_DIR}/scripts/*.coffee"]
        tasks: ["coffee:client"]
        options:
          spawn: no
          livereload: yes

      coffee_server:
        files: ["#{APP_DIR}/app.coffee"]
        tasks: ["coffee:server"]
        options:
          spawn: no

      view:
        files: ["#{APP_DIR}/views/**"]
        tasks: ["copy:views"]
        options:
          spawn: no
          livereload: yes

      statics:
        files: ["#{APP_DIR}/statics/**"]
        tasks: ["copy:statics"]
        options:
          spawn: no

      gruntfile:
          files: ["Gruntfile.coffee"]
          tasks: ["default"]
          options:
            reload: yes

    grunt.registerTask "default", ["clean:pub", "coffee", "sass", "concat", "copy", "clean:temp"]