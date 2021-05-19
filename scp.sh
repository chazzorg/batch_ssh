#!/bin/bash

#################### 方法体 ######################
# 应用白名单校验
funCheckApp(){
    if echo "${app_name[@]}" | grep -w "$app" &>/dev/null; then
        ips=($(eval echo '${'"$app"'_ips[@]}'))
        user=($(eval echo '${'"$app"'_user[@]}'))
        file=($(eval echo '${'"$app"'_file[@]}'))
        scp=($(eval echo '${'"$app"'_scp[@]}'))
    else
        echo "未授权项目"
        exit
    fi
}

# 复制脚本到目标服务器
funCopy(){
    ip=$1
    scp "${file[*]}${app}.sh" "${user[*]}"@${ip}:"${scp[*]}" >&/dev/null
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
funCheckApp $app

# 执行安装脚本
for((i=0;i<${#ips[@]};i++));
do
    funCopy ${ips[$i]}
done
