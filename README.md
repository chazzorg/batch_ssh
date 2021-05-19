# batch_ssh

## 目录介绍

```
.
├── scp                      # 上传文件存放目录
├── ssh.sh                   # 远程执行命令脚本
├── scp.sh                   # 发送文件到远程命令脚本
└─  env                      # 应用组配置文件

```

## 项目介绍

batch_ssh 可以让你发送文件到N台服务器。
batch_ssh 可以让你发送`shell`命令到N台服务器执行。

**使用概览：**

1. 编辑目录下`env`文件，配置服务器ip、用户等信息，参考示例配置
```bash
vi env
```

2. 赋予脚本执行权限
 ```bash
chmod 700 ./ssh.sh ./scp.sh
```

3. 通过应用组远程发送文件。
```bash
./scp.sh app
```

4. 通过应用组远程执行命令。
```bash
./ssh.sh app
```