#!/bin/sh

cp -rf /tmp/timingdial/timingdial /koolshare
cp -rf /tmp/timingdial/webs/* /koolshare/webs
cp -rf /tmp/timingdial/scripts/* /koolshare/scripts
cp -rf /tmp/timingdial/res/* /koolshare/res
cp -rf /tmp/timingdial/uninstall.sh /koolshare/scripts/uninstall_timingdial.sh

cd /
rm -rf /tmp/timingdial/ >/dev/null 2>&1
rm -rf /tmp/timingdial.tar.gz >/dev/null 2>&1

if [ "$(find /koolshare/init.d/ -name "*timingdial.sh" | wc -l)" -gt 0 ]; then
  rm -rf /koolshare/init.d/*timingdial.sh
fi

chmod 755 /koolshare/timingdial/*
chmod 755 /koolshare/init.d/*
chmod 755 /koolshare/scripts/*

/koolshare/timingdial/timingdial.sh writeversion
