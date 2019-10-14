require! {
  "gulp-rename":\rename
  "gulp-fontmin-woff2":\fontmin
}

require! <[
  ./src/ls/webpack/require_hacker.ls
  gulp
]>

gulp.task(
  'default'
  (done)~>
    done()
    # path = "public/font/6du/logo/cn"
    # gulp.src("#path.ttf")
    #   .pipe(rename('100.ttf'))
    #   .pipe(
    #     fontmin({
    #       text: require("./src/config/title.txt")
    #     })
    #   )
    #   .pipe(
    #     gulp.dest \public/font/6du/logo/cn
    #   )
)
