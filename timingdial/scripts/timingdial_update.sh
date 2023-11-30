#!/bin/sh

eval `dbus export timingdial_version`
eval `dbus export timingdial_enable`
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'

get_latest_release() {
  curl --silent https://api.github.com/repos/gshang2017/merlin-timingdial/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

install_timingdial(){
	cd /tmp/
	echo_date 开始解压压缩包...
	tar -zxf timingdial.tar.gz
	chmod a+x /tmp/timingdial/install.sh
	echo_date 开始安装更新文件...
	sh /tmp/timingdial/install.sh
	rm -rf /tmp/timingdial >/dev/null 2>&1
	rm -rf /tmp/timingdial.tar.gz >/dev/null 2>&1
	if [ "$timingdial_enable" == "1" ];then
		/koolshare/timingdial/timingdial.sh restart
  fi
}

check_update_timingdial_plugin(){
	echo_date 检测在线版本号...
	lastver=$(get_latest_release)
	if [ -n "$lastver" ];then
		echo_date 检测到在线版本号：$lastver
		oldver="v$timingdial_version"
		if [ "$oldver" != "$lastver" ];then
		echo_date 在线版本号："$lastver" 和本地版本号："$oldver" 不同！
			cd /tmp/
			echo_date 开启下载进程，下载更新包...
			wget --no-check-certificate --timeout=5 https://github.com/gshang2017/merlin-timingdial/releases/download/$lastver/timingdial.tar.gz
			if [ -e  "/tmp/timingdial.tar.gz" ] ; then
				echo_date 开始安装！...
				sleep 1
				install_timingdial
			else
				sleep 1
        rm -rf /tmp/timingdial >/dev/null 2>&1
        rm -rf /tmp/timingdial.tar.gz >/dev/null 2>&1
				echo_date 最新版本下载失败，请检查网络到github的连通后再试！
			fi
		else
			echo_date 在线版本号："$lastver" 和本地版本号："$oldver" 相同！
			echo_date 退出插件更新!
			sleep 1
			exit
		fi
	else
		echo_date 没有检测到在线版本号,请检查网络到github的连通后再试！
		sleep 1
	  exit
	fi
}

echo_date "==================================================================="
echo_date "                     timingdial插件更新                           "
echo_date "==================================================================="
check_update_timingdial_plugin
echo_date "==================================================================="
