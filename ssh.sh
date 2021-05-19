#!/bin/bash

#################### 方法体 ######################
# 应用白名单校验
funCheckApp(){
    if echo "${app_name[@]}" | grep -w "$app" &>/dev/null; then
        ips=($(eval echo '${'"$app"'_ips[@]}'))
        user=($(eval echo '${'"$app"'_user[@]}'))
        ssh=($(eval echo '${'"$app"'_ssh[@]}'))
    else
        echo "未授权项目"
        exit
    fi
}

# 调用对应项目拉取脚本
funSendCmd(){
    ip=$1
    ssh "${user[*]}"@${ip} "${ssh[*]}" < /dev/null >&/dev/null
    if [ $? -eq 0 ]; then
        echo -e "\033[32m ${app} $ip 执行成功 \033[0m"
    else
        echo -e "\033[31m ${app} $ip 执行失败 \033[0m"
    fi
}
#################### 方法体 ######################

# 加载服务器配置
source ./env
app=$1

# 校验服务
funCheckApp

# 执行发送命令
for((i=0;i<${#ips[@]};i++));
do
    funSendCmd ${ips[$i]}
done