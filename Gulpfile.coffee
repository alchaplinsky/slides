require('coffee-script/register')

gulp = require 'gulp'
$    = require('gulp-load-plugins')()
browserSync = require('browser-sync')
reload = browserSync.reload

gulp.task 'sass', ->
  gulp.src('src/stylesheets/**/*.sass')
  .pipe($.rubySass
    style: 'expanded'
    loadPath: ['src/stylesheets']
  ).pipe gulp.dest('assets/stylesheets')


gulp.task 'coffee', ->
  gulp.src('src/javascripts/application.coffee')
  .pipe($.coffee(bare: true).on('error', console.log))
  .pipe(gulp.dest('assets/javascripts'))


gulp.task 'serve', ->
  browserSync.init null,
    server:
      baseDir: ['assets', './']
    notify: false

  gulp.watch ['./*.html', 'slides/*.html'], reload
  gulp.watch ['src/stylesheets/**/*.sass'], ['sass']
  gulp.watch ['src/javascripts/**/*.coffee'], ['coffee']
  gulp.watch ['assets/stylesheets/**/*.css'], reload
  gulp.watch ['assets/javascripts/**/*.js'], reload

gulp.task 'default', (cb) ->
  gulp.start 'serve', cb
