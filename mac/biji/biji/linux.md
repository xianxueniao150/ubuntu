##Shell 输入/输出重定向
command > file  	 将输出重定向到 file。
command < file  	 将输入重定向到 file。
command >> file 	 将输出以追加的方式重定向到 file。
n > file        	 将文件描述符为 n 的文件重定向到 file。
n >> file       	 将文件描述符为 n 的文件以追加的方式重定向到 file。
n >& m          	 将输出文件 m 和 n 合并。
n <& m          	 将输入文件 m 和 n 合并。


```bash
如果希望 stderr 重定向到 file，可以这样写：
$ command 2>file
2 表示标准错误文件(stderr)。

如果希望将 stdout 和 stderr 合并后重定向到 file，可以这样写：
$ command > file 2>&1
```

##将Linux命令的结果作为下一个命令的参数
1. 符号：` `
作用：反引号括起来的字符串被shell解释为命令行，在执行时，shell首先执行该命令行，并以它的标准输出结果取代整个反引号（包括两个反引号）部分

2. $()
效果同` `

3. 命令：xargs
