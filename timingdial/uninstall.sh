#!/bin/sh

sh /koolshare/timingdial/timingdial.sh stop

rm /koolshare/webs/Module_timingdial.asp
rm /koolshare/res/icon-timingdial.png
rm /koolshare/scripts/timingdial_config.sh
rm /koolshare/scripts/timingdial_update.sh
rm -rf /koolshare/timingdial
rm -rf /koolshare/init.d/S99timingdial.sh

dbus remove timingdial_enable
dbus remove timingdial_wan0_ipaddr_prefix_set
dbus remove timingdial_dial_num_set
dbus remove timingdial_refresh_set
dbus remove timingdial_refresh_time_min_set
dbus remove timingdial_refresh_time_hour_set
dbus remove timingdial_refresh_time_day_set
dbus remove timingdial_refresh_time_month_set
dbus remove timingdial_refresh_time_week_set
dbus remove timingdial_perp_set
dbus remove timingdial_version

# remove start up command
sed -i '/timingdial_config.sh/d' /jffs/scripts/wan-start >/dev/null 2>&1

rm -rf /koolshare/scripts/uninstall_timingdial.sh
