#!/bin/bash

#################### 方法体 ######################
# 应用白名单校验
funCheckApp(){
    if echo "${app_name[@]}" | grep -w "$app" &>/dev/null; then
        ips=($(eval echo '${'"$app"'_ips[@]}'))
        user=($(eval echo '${'"$app"'_user[@]}'))
    else
        echo "未授权项目"
        exit
    fi
}

# 复制脚本到目标服务器
funCopy(){
    ip=$1
    if [ -d "$file" ]; then
        scp -r "$file" "${user[*]}"@${ip}:"$to_file" >&/dev/null
    else
        scp "$file" "${user[*]}"@${ip}:"$to_file" >&/dev/null
    fi
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
file=$2
to_file=$3

if [ ! -e "$file" ]; then
    echo -e "\033[31m 文件不存在，请重新选择!!!!!!!!! \033[0m"
    exit
fi

if [ ! -n "$to_file" ]; then
    echo -e "\033[31m 请输入目标服务器路径 \033[0m"
    exit
fi

# 校验服务
funCheckApp $app

# 执行安装脚本
for((i=0;i<${#ips[@]};i++));
do
    funCopy ${ips[$i]}
done
