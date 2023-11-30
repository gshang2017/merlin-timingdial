#!/bin/sh

# ====================================变量定义====================================
# 版本号定义
version="1.0"

# 导入skipd数据
eval `dbus export timingdial_enable`
eval `dbus export timingdial_wan0_ipaddr_prefix_set`
eval `dbus export timingdial_dial_num_set`
eval `dbus export timingdial_refresh_set`
eval `dbus export timingdial_refresh_time_min_set`
eval `dbus export timingdial_refresh_time_hour_set`
eval `dbus export timingdial_refresh_time_day_set`
eval `dbus export timingdial_refresh_time_month_set`
eval `dbus export timingdial_refresh_time_week_set`
eval `dbus export timingdial_perp_set`

# 引用环境变量等
source /koolshare/scripts/base.sh
export PERP_BASE=/koolshare/perp

# ====================================函数定义====================================

# 写入版本号
write_timingdial_version(){
	dbus set timingdial_version="$version"
}

#重拔PPPoE
restart_wan() {
	service restart_wan >/dev/null 2>&1 &
}

#检查IP前缀是否符合规则
check_timingdial_wan0_ipaddr_prefix_set() {
	if [ $timingdial_wan0_ipaddr_prefix_set  -lt 0 ] || [ $timingdial_wan0_ipaddr_prefix_set  -gt 255 ]; then
		dbus set timingdial_wan0_ipaddr_prefix_set=0
	fi
}

#检查拨号次数
check_timingdial_dial_num_set() {
	if [ $timingdial_dial_num_set -lt 1 ] || [ $timingdial_dial_num_set -gt 15 ]; then
		dbus set timingdial_dial_num_set=5
	fi
}

#检查外网IP是否符合设置的规则
check_wan0_ipaddr() {
	sleep 20
	i=1
	while [ `nvram get wan0_ipaddr|awk -F. '{print $1}'` -ne $timingdial_wan0_ipaddr_prefix_set ] && [ $i -le $timingdial_dial_num_set ]
	do
		service restart_wan >/dev/null 2>&1 &
		sleep 20
		let i++
	done
}

#将执行脚本写入crontab定时运行
add_timingdial_cru(){
	if [ -f /koolshare/timingdial/timingdial.sh ]; then
		#确保有执行权限
		chmod +x /koolshare/timingdial/timingdial.sh
		cru a timingdial_refresh "$timingdial_refresh_time_min_set $timingdial_refresh_time_hour_set $timingdial_refresh_time_day_set $timingdial_refresh_time_month_set $timingdial_refresh_time_week_set /koolshare/timingdial/timingdial.sh timingdial"
	fi
}

#设置perp
perp_set(){
	if [ "$timingdial_enable" == "1" ] && [ "$timingdial_perp_set" == "1" ] ;then
		cru d timingdial_perp
		cru a timingdial_perp "*/1 * * * *   /koolshare/timingdial/timingdial.sh perp_restart"
	elif [ "$timingdial_enable" == "1" ] && [ "$timingdial_perp_set" == "2" ] ;then
		cru d timingdial_perp
		cru a timingdial_perp "*/10 * * * *   /koolshare/timingdial/timingdial.sh perp_restart"
	elif [ "$timingdial_enable" == "1" ] && [ "$timingdial_perp_set" == "3" ] ;then
		cru d timingdial_perp
		cru a timingdial_perp "*/30 * * * *   /koolshare/timingdial/timingdial.sh perp_restart"
	elif [ "$timingdial_enable" == "1" ] && [ "$timingdial_perp_set" == "4" ] ;then
		cru d timingdial_perp
		cru a timingdial_perp "* */1 * * *   /koolshare/timingdial/timingdial.sh perp_restart"
	else
		cru d timingdial_perp
  fi
}
#重启perp
timingdial_perp(){
	sleep 5
	if  [ -z "`cru l|grep timingdial_refresh`" ];then
		add_timingdial_cru
	fi
	if  [ -z "`cru l|grep timingdial_perp`" ];then
		perp_set
	fi
}
#停止服务
stop_timingdial(){
	#停掉cru里的任务
    local timingdialcru=$(cru l | grep "timingdial")
	if [ ! -z "$timingdialcru" ]; then
		cru d timingdial_refresh
	fi
}

# 写入版本号
write_timingdial_version(){
	dbus set timingdial_version="$version"
}

# 自动触发程序
auto_start(){
	# creat start_up file
	if [ ! -L "/koolshare/init.d/S99timingdial.sh" ]; then
		if [ `ls /koolshare/init.d|grep "timingdial.sh"|wc -l` -gt 0 ]; then
			rm /koolshare/init.d/*timingdial.sh
		fi
		ln -sf /koolshare/timingdial/timingdial.sh /koolshare/init.d/S99timingdial.sh
	fi
	# nat_auto_start
	mkdir -p /jffs/scripts
	# wan_auto_start
	# Add service to auto start
	if [ ! -f /jffs/scripts/wan-start ]; then
		cat > /jffs/scripts/wan-start <<-EOF
			#!/bin/sh
			/usr/bin/onwanstart.sh

			EOF
		chmod +x /jffs/scripts/wan-start
	fi

	starttimingdial=$(cat /jffs/scripts/wan-start | grep "/koolshare/scripts/timingdial_config.sh")
	if [ -z "$starttimingdial" ];then
		#添加wan-start触发事件...
		sed -i '2a sh /koolshare/scripts/timingdial_config.sh' /jffs/scripts/wan-start
    chmod +x /jffs/scripts/wan-start
	fi
}

# ====================================主逻辑====================================

case $ACTION in
start)
	#此处为开机自启动设计
	if [ "$timingdial_enable" == "1" ];then
		auto_start
		write_timingdial_version
		check_timingdial_wan0_ipaddr_prefix_set
		check_timingdial_dial_num_set
		if [ "$timingdial_refresh_set" != "2" ];then
			check_wan0_ipaddr
	    fi
		add_timingdial_cru
		perp_set
	fi
	;;
stop | kill )
	stop_timingdial
	perp_set
	;;
timingdial)
	if [ "$timingdial_refresh_set" != "2" ];then
		restart_wan
	fi
	if [ "$timingdial_refresh_set" != "1" ];then
		check_wan0_ipaddr
	fi
	sleep 5
	add_timingdial_cru
	;;
writeversion)
	write_timingdial_version
	;;
restart)
	stop_timingdial
	auto_start
	write_timingdial_version
	check_timingdial_wan0_ipaddr_prefix_set
	check_timingdial_dial_num_set
	if [ "$timingdial_refresh_set" != "2" ];then
		check_wan0_ipaddr
	fi
	add_timingdial_cru
	perp_set
	;;
perp_restart)
	timingdial_perp
  ;;
*)
	echo "Usage: $0 (start|stop|restart|kill)"
	exit 1
	;;
esac
