# Linux boot script for Android v5.0.2
# OS : Arch Linux
# Image : /sdcard/archlinux/archlinux-CORE.ext4.img

error_exit() {
    echo "Error: $1"
    exit 1
}

if [ -f /data/data/com.zpwebsites.linuxonandroid/files/busybox ]; then
      	export bbox=/data/data/com.zpwebsites.linuxonandroid/files/busybox
elif [ -f /data/data/com.zpwebsites.linuxonandroid.opensource/files/busybox ]; then
      	export bbox=/data/data/com.zpwebsites.linuxonandroid.opensource/files/busybox
else
	export bbox=/system/xbin/busybox
fi

export usermounts=android
export sd=/sdcard
export arch=arch
export file=archlinux.img
export imgfile=$sd/$arch/$file
export bin=/system/bin
export mnt=/data/local/mnt
export USER=root
if [[ ! -d $mnt ]]; then mkdir $mnt; fi
export PATH=$bin:/usr/bin:/usr/local/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/games:$PATH
export TERM=linux
export HOME=/root
unset LD_PRELOAD

if [ $# -ne 0 ]; then
    if [ -f $1 ]; then
        imgfile=$1

	elif [ -f $(dirname $0)/$1 ]; then # Is only a filename present?
        imgfile=$(dirname $0)/$1

    elif [ -f /sdcard/arch/*.img ];then
        imgfile=/sdcard/arch/*.img

    elif [ -f /sdcard/archlinux/*.img ];then
        imgfile=/sdcard/archlinux/*.img

	else
        error_exit "Image file not found!($1)"
    fi
fi

if [ -f $imgfile.md5 ]; then
        echo "MD5 file found, use to check .img file? (y/n)"
	read answer
	if [ $answer == y ]; then
	     echo -n "Validating image checksum... "
    	     $bbox md5sum -c -s $imgfile.md5
    	     if [ $? -ne 0 ];then
                  echo "FAILED!"
                  error_exit "Checksum failed! The image is corrupted!"
             else
                  echo "OK"
                  rm $imgfile.md5
             fi
	fi
   
fi

use_swap=yes
cfgfile=$imgfile.config

if [ -f $imgfile.config ]; then
	source $imgfile.config
fi

if [ $use_swap == yes ]; then
	if [ -f $imgfile.swap ]; then
		echo "Swap file found, using file"
		echo "Turning on swap (if it errors here you do not have swap support"
		swapon $imgfile.swap
		
	else
		echo "Creating Swap file"
		dd if=/dev/zero of=$imgfile.swap bs=1048576 count=1024
		#dd if=/dev/zero of=$imgfile.swap bs=2000000 count=1024
		mkswap $imgfile.swap
		echo "Turning on swap (if it errors here you do not have swap support"
		swapon $imgfile.swap
			
	fi
fi

echo -n "Checking loop device... "
if [ -b /dev/block/loop255 ]; then
	echo "FOUND"
else
	echo "MISSING"
	echo -n "Creating loop device... "
	$bbox mknod /dev/block/loop255 b 7 255
	if [ -b /dev/block/loop255 ]; then
		echo "OK"
	else
		echo "FAILED"
		#error_exit "Unable to create loop device!"
	fi
fi

$bbox which ls
if [ $? -ne 1 ];then

    $bbox losetup /dev/block/loop255 $imgfile
    #if [ $? -ne 0 ];then error_exit "Unable to attach image to loop device! (Image = $imgfile)"; fi
    $bbox mount -t ext4 /dev/block/loop255 $mnt
    #if [ $? -ne 0 ];then error_exit "Unable to mount the loop device!"; fi
    $bbox mount -t devpts devpts $mnt/dev/pts
    if [ $? -ne 0 ];then $bbox mount -o bind /dev $mnt/dev; $bbox mount -t devpts devpts $mnt/dev/pts; fi 
    #if [ $? -ne 0 ]; then error_exit "Unable to mount $mnt/dev/pts!"; fi
    $bbox mount -t proc proc $mnt/proc
    #if [ $? -ne 0 ];then error_exit "Unable to mount $mnt/proc!"; fi
    $bbox mount -t sysfs sysfs $mnt/sys
    #if [ $? -ne 0 ];then error_exit "Unable to mount $mnt/sys!"; fi
    $bbox mount -o bind /sdcard $mnt/sdcard
    #if [ $? -ne 0 ];then error_exit "Unable to bind $mnt/sdcard!"; fi

else
    echo -e "Error: busybox no command,\nln -s $bbox /system/xbin..."

    for i in $($bbox --list); do
      ln -s $bbox "/system/xbin/${i}"
    done

    $bbox losetup /dev/block/loop255 $imgfile
    $bbox mount -t ext4 /dev/block/loop255 $mnt
    $bbox mount -t devpts devpts $mnt/dev/pts
    $bbox mount -t proc proc $mnt/proc
    $bbox mount -t sysfs sysfs $mnt/sys
    $bbox mount -o bind /sdcard $mnt/sdcard
fi

if [[ ! -d $mnt/root/cfg ]]; then mkdir $mnt/root/cfg; fi
$bbox mount -o bind $(dirname $imgfile) $mnt/root/cfg
$bbox mount -o bind /sys/fs/selinux $mnt/selinux

if [ -d /sdcard/external_sd ]; then
	$bbox mount -o bind /sdcard/external_sd  $mnt/external_sd
fi
if [ -d /Removable/MicroSD ]; then
	$bbox mount -o bind /Removable/MicroSD  $mnt/external_sd
fi
if [ -d /storage ]; then
	$bbox mount -o bind /storage  $mnt/external_sd
fi

if [ -f $imgfile.mounts ]; then
	olddir=$(pwd)
	echo "Mounting user mounts"

	cd $mnt
	if [[ ! -d $mnt/$usermounts ]]; then $bbox mkdir -p $usermounts; fi

	echo "# Script to unmount user defined mounts, do not delete or edit!" > $imgfile.shutdown
	echo "cd $mnt/$usermounts" > $imgfile.shutdown

	cd $mnt/$usermounts
	for entry in $(cat "$imgfile.mounts"); do
		ANDROID=${entry%;*}
		LINUX=${entry#*;}

		if [[ -d $ANDROID ]]; then
			echo -n "Mounting $ANDROID to $usermounts/$LINUX... "
			if [[ ! -d $mnt/$usermounts/$LINUX ]]; then $bbox mkdir -p $LINUX; fi
			$bbox mount -o bind $ANDROID $mnt/$usermounts/$LINUX &> /dev/null
			if [ $? -ne 0 ];then
				echo FAIL
				if [[ -d $mnt/$usermounts/$LINUX ]]; then $bbox rmdir -p $LINUX; fi
			else
				echo OK
				echo "$bbox umount $mnt/$usermounts/$LINUX" >> $imgfile.shutdown
				echo "$bbox rmdir -p $LINUX" >> $imgfile.shutdown
			fi
		else
			echo "Android folder not found: $ANDROID"
		fi
	done
	echo "cd $mnt" >> $imgfile.shutdown
	echo "$bbox rmdir -p $usermounts" >> $imgfile.shutdown
	cd $olddir

else
	echo "No user defined mount points"
fi

$bbox sysctl -w net.ipv4.ip_forward=1
if [ $? -ne 0 ];then error_exit "Unable to forward network!"; fi

if [ ! -f $mnt/root/DONOTDELETE.txt ]; then
	echo "nameserver 8.8.8.8" > $mnt/etc/resolv.conf
	if [ $? -ne 0 ];then error_exit "Unable to write resolv.conf file!"; fi
	echo "nameserver 8.8.4.4" >> $mnt/etc/resolv.conf
	echo "127.0.0.1 localhost" > $mnt/etc/hosts
	if [ $? -ne 0 ];then error_exit "Unable to write hosts file!"; fi
fi

$bbox chroot $mnt /root/init.sh $(basename $imgfile)

unset LD_PRELOAD

echo "Shutting down Linux ARM"
umount /sdcard/mnt/usb2
umount /sdcard/mnt/usb3
#for pid in `lsof | grep $mnt | sed -e's/  / /g' | cut -d' ' -f2`; do kill -9 $pid >/dev/null 2>&1; done
for pid in `$bbox lsof | $bbox grep $mnt | $bbox sed -e's/  / /g' | $bbox cut -d' ' -f2`; do $bbox kill -9 $pid >/dev/null 2>&1; done
sleep 5

if [ -f $imgfile.shutdown ]; then
	echo "Unmounting user defined mounts"
	sh $imgfile.shutdown
	rm $imgfile.shutdown
fi

$bbox umount $mnt/root/cfg
$bbox umount $mnt/sdcard
$bbox umount $mnt/external_sd
$bbox umount $mnt/dev/pts
$bbox umount $mnt/dev
$bbox umount $mnt/proc
$bbox umount $mnt/sys
$bbox umount $mnt/selinux
$bbox umount $mnt
$bbox losetup -d /dev/block/loop255 &> /dev/null
