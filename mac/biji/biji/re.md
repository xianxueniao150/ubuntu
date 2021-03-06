### 中括号表达式
一个字符集合可能包含任意多个字符，并且元字符被放置到中括号里面后会失去了它们的特殊含义。 然而，在两种情况下，会在中括号表达式中使用元字符，并且有着不同的含义。第一个元字符 是插入字符，其被用来表示否定；第二个是连字符字符，其被用来表示一个字符区域。
怎样在一个正则表达式中包含一个连字符呢？ 方法就是使连字符成为表达式中的第一个字符。考虑一下这两个例子：
```
$ grep -h '[A-Z]' dirlist*.txt
#下面的表达式会匹配包含一个连字符，或一个大写字母“A”，或一个大写字母“Z”的文件名
$ grep -h '[-AZ]' dirlist*.txt
```

### POSIX 字符集
追溯到 Unix 刚刚开发的时候，它只知道 ASCII 字符，随着 Unix 系统的知名度在美国之外的国家传播开来，就需要支持不在 U.S.英语范围内的字符。 于是就扩展了这个 ASCII 字符表，使用了整个8位，添加了字符（数字128－255），这样就 容纳了更多的语言。

为了支持这种能力，POSIX 标准介绍了一种叫做 locale 的概念，其可以被调整，来为某个特殊的区域， 选择所需的字符集。
通过这个设置，POSIX 相容的应用程序将会使用字典排列顺序而不是 ASCII 顺序。这就解释了上述命令的行为。 当[A-Z]字符区域按照字典顺序解释的时候，包含除了小写字母“a”之外的所有字母，因此得到这样的结果。

为了部分地解决这个问题，POSIX 标准包含了大量的字符集，其提供了有用的字符区域。 下表中描述了它们：

- [:alnum:]	字母数字字符。在 ASCII 中，等价于：[A-Za-z0-9]
- [:word:]	与[:alnum:]相同, 但增加了下划线字符。
- [:alpha:]	字母字符。在 ASCII 中，等价于：[A-Za-z]
- [:blank:]	包含空格和 tab 字符。
- [:cntrl:]	ASCII 的控制码。包含了0到31，和127的 ASCII 字符。
- [:digit:]	数字0到9
- [:graph:]	可视字符。在 ASCII 中，它包含33到126的字符。
- [:lower:]	小写字母。
- [:punct:]	标点符号字符。在 ASCII 中，等价于：
- [:print:]	可打印的字符。在[:graph:]中的所有字符，再加上空格字符。
- [:space:]	空白字符，包括空格，tab，回车，换行，vertical tab, 和 form feed.在 ASCII 中， 等价于：[ \t\r\n\v\f]
- [:upper:]	大写字母。
- [:xdigit:]	用来表示十六进制数字的字符。在 ASCII 中，等价于：[0-9A-Fa-f]

## 扩展的正则表达式
### POSIX 基本的 Vs.扩展的正则表达式
POSIX 把正则表达式的实现分成了两类： 基本正则表达式（BRE）和扩展的正则表达式（ERE）。
BRE 可以辨别以下元字符：
```
^ $ . [ ] *
```
其它的所有字符被认为是文本字符。ERE 添加了以下元字符（以及与其相关的功能）:
```
( ) { } ? + |
```

- ? 使前面的元素可有可无
- * 匹配零个或多个元素 
- + 匹配一个或多个元素
- 

在 BRE 中，字符“(”，“)”，“{”，和 “}”用反斜杠转义后，被看作是元字符, 相反在 ERE 中，在任意元字符之前加上反斜杠会导致其被看作是一个文本字符。

### Alternation
就像中括号表达式允许从一系列指定的字符之间匹配单个字符那样， alternation 允许从一系列字符串或者是其它的正则表达式中选择匹配项
```
$ echo "AAA" | grep -E 'AAA|BBB|CCC'
AAA

#为了把 alternation 和其它正则表达式元素结合起来，我们可以使用()来分离 alternation。
$ grep -Eh '^(bz|gz|zip)' dirlist*.txt
```

### { } - 匹配特定个数的元素
这个 { 和 } 元字符都被用来表达要求匹配的最小和最大数目。它们可以通过四种方法来指定：

- {n} 	匹配前面的元素，如果它确切地出现了 n 次。
- {n,m}	匹配前面的元素，如果它至少出现了 n 次，但是不多于 m 次。
- {n,}	匹配前面的元素，如果它出现了 n 次或多于 n 次。
- {,m}	匹配前面的元素，如果它出现的次数不多于 m 次。

## 支持正则表达式的命令 
```
$ find . -regex '.*[^-\_./0-9a-zA-Z].*'
$ locate --regex 'bin/(bz|gz|zip)'
$ less phonelist.txt
```
vim 支持基本的正则表达式；所以我们用于搜索的表达式看起来像这样：
```
/([0-9]\{3\}) [0-9]\{3\}-[0-9]\{4\}
```
然而，在扩展表达式中，许多被认为是元字符的字符在基本的表达式 中被看作是文本字符。只有用反斜杠把它们转义之后，它们才被看作是元字符。

<++>
