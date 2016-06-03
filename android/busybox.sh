#!/system/bin/sh

if [ -f /data/data/com.zpwebsites.linuxonandroid/files/busybox ]; then
    export bbox=/data/data/com.zpwebsites.linuxonandroid/files/busybox
elif [ -f /data/data/com.zpwebsites.linuxonandroid.opensource/files/busybox ]; then
    export bbox=/data/data/com.zpwebsites.linuxonandroid.opensource/files/busybox
elif [ -f /system/xbin/busybox ]; then
    export bbox=/system/xbin/busybox
else
  echo "Error: no busybox"
  exit
fi

for i in $($bbox --list); do
  ln -s $bbox "/system/xbin/${i}"
done

