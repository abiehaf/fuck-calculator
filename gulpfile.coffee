gulp = require 'gulp'
gif = require 'gulp-if'
jade = require 'gulp-jade'
less = require 'gulp-less'
minifyCss = require 'gulp-minify-css'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
serve = require 'gulp-serve'

DEBUG = process.env.NODE_ENV isnt 'release'

SRC_DIR = 'src'
DEST_DIR = 'build'

gulp.task 'index', ->
  gulp.src "#{SRC_DIR}/index.jade"
  .pipe jade locals: {DEBUG: DEBUG}, pretty: DEBUG
  .pipe gulp.dest DEST_DIR

gulp.task 'style', ->
  gulp.src "#{SRC_DIR}/styles/style.less"
  .pipe less()
  .pipe gif !DEBUG, minifyCss()
  .pipe gulp.dest "#{DEST_DIR}/css"

gulp.task 'script', ->
  gulp.src "#{SRC_DIR}/scripts/**/*.coffee"
  .pipe concat 'main.coffee'
  .pipe coffee()
  .pipe gif !DEBUG, uglify()
  .pipe gulp.dest "#{DEST_DIR}/js"

gulp.task 'build', ['index', 'style', 'script']

gulp.task 'watch', ['build'], ->
  gulp.watch ["#{SRC_DIR}/*.jade"], ['index']
  gulp.watch "#{SRC_DIR}/styles/**/*.less", ['style']
  gulp.watch "#{SRC_DIR}/scripts/**/*.coffee", ['script']

gulp.task 'serve', ['watch'], serve DEST_DIR