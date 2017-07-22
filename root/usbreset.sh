#!/bin/sh -x
#
v="12d1"
p="1f01"
m="55534243123456780000000000000a11062000000000000100000000000000"
#
tr=`which tr`
grep=`which grep`
head=`which head`
leep=`which sleep`
uconf=`which usbconfig`
uswitch=`which usb_modeswitch`
ifcfg=`which ifconfig`
rt=`which route`
#
dev=`$uconf | $grep $1 | $tr ':' '\n' | $head -n1`
echo $dev
exit
#
$leep 1; $uconf -d $dev power_off
$leep 5; $uconf -d $dev power_on
$leep 5; $uswitch -v$v -p$p -M$m &
$leep 9; $ifcfg ue0 192.168.8.2/24
$leep 1; $rt add default 192.168.8.1
$leep 1; $ifcfg ue0 up
#
/etc/pf/snr.1.sh ue0
#
ping="`which ping` -q -c 1 -W 1"
ntpq="`which ntpdate` -4 -v -b"
if $ping ntp1.vniiftri.ru >/dev/null; then
 $ntpq ntp1.vniiftri.ru >> /var/log/ntpd.log
fi
