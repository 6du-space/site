require! <[
  require-hacker
  fs
]>


# 导入txt格式的文本  
requireHacker.hook(
  \txt
  (path) ~>
    txt = fs.readFileSync path,"utf-8"
      .replace /^[\s\r\n]+|[\s\n\r]+$/g ''
      .replace /'/g "'"
      .replace /\n/g "\\n"

    "module.exports = '#{txt}'"
)

