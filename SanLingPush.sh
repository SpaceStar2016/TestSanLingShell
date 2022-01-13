#!/bin/bash

# 此脚本用于把一个分支的代码合并到另外一个分支
# 此脚本用于把A分支(sourceBranch)的代码合并到 B分支(targetBranch)
# $1 为 sourceBranch $2为targetBranch 如果没传默认$1为“develop”，$2为“develop_SanLing”

sourceBranch="develop"
targetBranch="develop_SanLing"

function echoGreen(){
	echo -e "\033[32m $1 \033[0m"  
}

function echoRed(){
	echo -e "\033[31m $1 \033[0m"  
}

# 获取当前所在的分支
function getCurrentBranch(){
    currentBranchFull=$(git symbolic-ref HEAD)
	currentBranchPrefix='refs/heads/'
	currentBranch=${currentBranchFull#*$currentBranchPrefix}
    echo $currentBranch
}

# 判断本地是否存在对应的分支
function isLocalBranchExist(){
	#本地有对应分支，返回0
	#没有，返回1
	git rev-parse --verify $1
}

# 判断远程是否存在分支
function isRemoteBranchExist(){
    git branch -r | grep "origin/$1"
}
merginInfo=()
incIndex=0
function saveMergeLog(){
    errorInfo=$1
	merginInfo[incIndex]=$errorInfo
	incIndex=$(($incIndex+1))
	return 0
}

function logMergeInfo(){
    for var in ${merginInfo[@]};
	do
    	echo $var
	done
}


#-n 用于判断字符是否有值 -a a代表 and的意思 相当于 &&
if [ -n "$1" -a  -n "$2" ];then
    sourceBranch=$1
    targetBranch=$2
fi

echo "sourceBranch == $sourceBranch"
echo "targetBranch == $targetBranch"

function mergeBranch(){

    lastMessage=`git status | tail -n 2`
    echo $lastMessage
#nothing to commit, working tree clean 本地没有变化
    noCommit='nothing to commit'
 
if [[ $lastMessage =~ $noCommit ]]; then
    echo "无需提交"
else
 git add .
 git commit -m"auto push"
 git push origin develop_SanLing
fi

    # echo "🟡 git status:"
	# statusret=$(git status .)
    # echo $statusret

    # lastMessage=`git status . | grep "On branch develop_SanLing Changes not staged for cssommi" `
#nothing to commit, working tree clean 本地没有变化
    # noCommit='nothing to commit'
# if [ $? -eq 0 ]; then
#     echoRed " ❌ 是否有修改"
# fi
# if [[ $lastMessage =~ $noCommit ]]; then
#     echo "无需提交"
#     exit
# fi

    # git status .
    # if [ ! $? -eq 0 ]; then
    #     echoRed " ❌ 是否有修改"
    # fi
    # return 0
    # # cur_dir=$(dirname $(pwd))
    # # cd "$cur_dir/$1"
    # # if [ ! $? -eq 0 ]; then
    # #     echoRed " ❌ 没有这个目录"
    # # return 0
    # # fi

    # repository=$1
    # # 获取当前分分支名称
	# currentBranch=$(getCurrentBranch)
    # echoGreen "当前分支为$currentBranch"
    # # 判断远程仓库是否存在targetBranch
    # if [[ ! $(isRemoteBranchExist $targetBranch) ]]; then
    #     echoGreen " 远程没有这个分支，利用$sourceBranch 编译"
    #     # 拉取 sourceBranch 最新代码
    #     git pull
    #     saveMergeLog "🟢仓库****$repository****分支:$currentBranch"
    #     return 0
    # fi
    # # 判断当前branch是否是targetBranch
    # if [ $currentBranch != $targetBranch ];then
    #     # 判断本地是否存在
    #     if [[ ! $(isLocalBranchExist $targetBranch) ]]; then
    #         # 切换分支到targetBranch
    #         git checkout -b $targetBranch
    #     else
    #         # 切换分支到targetBranch
    #         git checkout $targetBranch
    #     fi
    #     if [ ! $? -eq 0 ]; then
    #         saveMergeLog "❌切换分支失败***$repository***currentBranch$currentBranch***targetBranch***$targetBranch"
    #         return 0
    #     fi
    #     currentBranch=$(getCurrentBranch)
    # fi
    # git pull origin $sourceBranch
    # # 处理合并冲突,没有冲突命令返回成功
    # if [ ! $? -eq 0 ]; then
    #     saveMergeLog "❌请处理错误仓库***$repository***分支***$currentBranch"
    # else
    #     saveMergeLog "🟢合并成功--仓库***$repository***分支***$currentBranch"
    # fi

}

mergeBranch
# mergeBranch "Dolphinrouter";
# mergeBranch "Dolphinperformance";
# mergeBranch "BHCodescan";
# mergeBranch "DolphinFramework";
# mergeBranch "OEMFoundation";
# mergeBranch "OEMMessageCenter";
# mergeBranch "OEMBusiness";
# mergeBranch "OEMDevice";
# mergeBranch "OEMBluetooth";
# mergeBranch "OEMHome";
# mergeBranch "OEMMine";
# mergeBranch "OEMLogin";
# mergeBranch "OEMReactNative";
# mergeBranch "OEMTheme";

logMergeInfo