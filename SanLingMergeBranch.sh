#!/bin/bash

# 此脚本用于把一个分支的代码合并到另外一个分支
# 此脚本用于三菱项目用于把develop分支(sourceBranch)的代码合并到 SanLing项目分支(targetBranch)

echoGreen(){
	echo -e "\033[32m $1 \033[0m"  
}

echoRed(){
	echo -e "\033[31m $1 \033[0m"  
}

echo "输入的第一个参数:$1"
echo "输入的第二个参数:$2"
sourceBranch="develop"
targetBranch="develop_SanLing"

#-n 用于判断字符是否有值 -a a代表 and的意思 相当于 &&
if [ -n "$1" -a  -n "$2" ];then
    sourceBranch=$1
    targetBranch=$2
fi
echo "sourceBranch == $sourceBranch"
echo "targetBranch == $targetBranch"

function mergeBranch(){
    # dir=$1
    # cd dir
    # if [ ! $? -eq 0 ]; then
    # return 0
    # fi
    # 获取当前分分支名称
    currentBranchFull=$(git symbolic-ref HEAD)
	currentBranchPrefix='refs/heads/'
	currentBranch=${currentBranchFull#*$currentBranchPrefix}
    # 判断是否是targetBranch
    if [ $currentBranch != $targetBranch ];then
        # 切换分支到targetBranch
        git checkout $targetBranch
        if [ ! $? -eq 0 ]; then
            echoRed "切换分支失败: $targetBranch"
            return 0
        fi
    fi
    git pull origin $sourceBranch

}
mergeBranch 