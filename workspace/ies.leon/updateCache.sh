cd sdk
dstDir=cache

rm -rf $dstDir
mkdir $dstDir

cp -a sdk-xlp-2.3/linux/usr/rootfs.xlp $dstDir

cp -a sdk-xgs-robo-6.3.9/src/customer/ $dstDir/customer-src
cp -a sdk-xgs-robo-6.3.9/include/customer/ $dstDir/customer-include

