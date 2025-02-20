问题：
DH编译出现shadowsocks-rust编译失败

问题分析：
问题来自于编译hello world这个应用是出现shadowsocks-rust编译失败。

解决方案：
1.在.config里面删除有关Hello world的选项
2.在.sh文件里面有关下载的hello world库的链接删除掉
