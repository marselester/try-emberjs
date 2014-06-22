module.exports = (grunt) ->
  config =
    pkg:
      grunt.file.readJSON('package.json')
    coffee:
      compile_dev:
        files: [
          dest: 'dev/scripts/'
          cwd: 'app/scripts/'
          src: '**/*.coffee'
          ext: '.js'
          expand: true
        ]
  grunt.initConfig(config)

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.registerTask('default', ['coffee']);
