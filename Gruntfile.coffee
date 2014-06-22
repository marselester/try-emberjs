module.exports = (grunt) ->
  config =
    appDest: 'compiled_app'
    coffee:
      dev:
        files: [
          dest: '<%= appDest %>/scripts/'
          cwd: 'app/scripts/'
          src: '**/*.coffee'
          ext: '.js'
          expand: true
        ]
    symlink:
      dev:
        files: [
          {'<%= appDest %>/vendor/': 'app/vendor/'}
          {'<%= appDest %>/index.html': 'app/index.html'}
        ]

  grunt.initConfig(config)

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-symlink')
  grunt.registerTask('default', ['coffee', 'symlink']);
