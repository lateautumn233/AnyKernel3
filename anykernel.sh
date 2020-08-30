# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

# Set up working directory variables
test "$home" || home=$PWD;
split_img=$home/split_img;

## AnyKernel setup
# begin properties
properties() { '
kernel.string=HiiraKernel @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=lmi
device.name2=lmipro
supported.versions=10
'; } # end properties

# shell variables
block=/dev/block/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

if [ ! -f $home/source/Image.gz ] || [ ! -f $home/source/dtb ]; then
    ui_print " " "This zip is corrupted! Aborting..."; exit 1;
fi

mv $home/source/Image.gz $home/Image.gz;

## AnyKernel install
dump_boot;

mv $home/source/dtb $home/split_img/;

# Clean up existing ramdisk overlays
rm -rf $ramdisk/overlay;
rm -rf $ramdisk/overlay.d;

write_boot;
## end install
