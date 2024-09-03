#!/data/data/com.termux/files/usr/bin/sh

# $PREFIX/etc/profile starts all scripts in profile.d
# where start-services.sh is located - which in turn
# will start all termux-services (including cron)
termux-wake-lock
. $PREFIX/etc/profile
