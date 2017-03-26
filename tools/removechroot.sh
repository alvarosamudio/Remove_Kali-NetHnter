#!/sbin/sh
# Install Kali chroot

tmp=$(readlink -f "$0")
tmp=${tmp%/*/*}
. "$tmp/env.sh"

zip=$1

console=$(cat /tmp/console)
[ "$console" ] || console=/proc/$$/fd/1

print() {
	echo "ui_print - $1" > $console
	echo
}

NHSYS=/data/local/nhsystem

verify_fs() {
	# valid architecture?
	case $FS_ARCH in
		armhf|arm64|i386|amd64) ;;
		*) return 1 ;;
	esac
	# valid build size?
	case $FS_SIZE in
		full|minimal) ;;
		*) return 1 ;;
	esac
	return 0
}
	# HACK 1/2: Rename to kali-armhf until NetHunter App supports searching for best available arch
	CHROOT="$NHSYS/kali-armhf"
	#CHROOT="$NHSYS/kali-$FS_ARCH"

	# Remove previous chroot
	[ -d "$CHROOT" ] && {
		print "Removing previous chroot..."
		rm -rf "$CHROOT"
	}

