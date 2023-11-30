#!/bin/sh

eval `dbus export timingdial_enable`

if [ "$timingdial_enable" == "1" ];then
	/koolshare/timingdial/timingdial.sh restart
else
	/koolshare/timingdial/timingdial.sh stop
fi
