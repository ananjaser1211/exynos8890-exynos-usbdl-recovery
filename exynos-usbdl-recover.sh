#!/bin/bash
# Simple exynos-usbdl

CHECK(){
echo " "
echo " Checking for flash binary "
if [ ! -e exynos-usbdl ]; then
	echo " ERR: Binary Missing  "
	exit
else
	echo " Success "
fi

echo " "
echo " Checking if run as root "

if [ "$EUID" -ne 0 ]
  then echo " ERR: Please re-run as root"
  exit
else
	echo " Success "
fi

echo " "
echo " Checking for s-boot split binary "

if [ ! -d $CR_TARGET ]; then
	echo " "
	echo " ERR: Split-SBOOT for $CR_TARGET is Missing! - Re-download"
	exit
elif [ ! -f $CR_TARGET/fwbl1.bin ]; then
	echo " "
	echo " ERR: fwbl1.bin Missing"
	exit
elif [ ! -f $CR_TARGET/el3_mon.bin ]; then
	echo " "
	echo " ERR: el3_mon.bin Missing"
	exit
elif [ ! -f $CR_TARGET/bl2.bin ]; then
	echo " "
	echo " ERR: bl2.bin Missing"
	exit
elif [ ! -f $CR_TARGET/bootloader.bin ]; then
	echo " "
	echo " ERR: bootloader.bin Missing"
	exit
else
	echo " Success "
fi
}

DEVICE_DIR(){
	if [ "$CR_TARGET" = "1" ]; then
		echo " "
		echo " Selected Galaxy S7 Flat - SM-G930F"
		CR_TARGET=G930F
	fi
	if [ "$CR_TARGET" = "2" ]; then
		echo " "
		echo " Selected Galaxy S7 Edge - SM-G935F"
		CR_TARGET=G935F
	fi
	if [ "$CR_TARGET" = "3" ]; then
		echo " "
		echo " Selected Galaxy Note7 FE - SM-N935F"
		CR_TARGET=N935F
	fi
}

FLASH(){
	echo " "
	echo " Start Flashing ..."
	echo " "
	echo " Plug your device and HOLD the POWER button "
	echo " "
	sleep 5

	./exynos-usbdl n $CR_TARGET/fwbl1.bin
	sleep 1
	./exynos-usbdl n $CR_TARGET/el3_mon.bin
	sleep 1
	./exynos-usbdl n $CR_TARGET/bl2.bin
	sleep 1
	./exynos-usbdl n $CR_TARGET/bootloader.bin
}

# Menu
clear
echo "----------------------------------------------"
echo "exynos8890-usbdl recovery"
echo " "
echo "1) herolte (SM-G930F)" "2) hero2lte (SM-G935F)" 
echo "3) gracerlte (SM-N935F)" "4) Abort" 
echo  " "
echo "----------------------------------------------"
read -p "Please select your device (1-3) > " CR_TARGET
if [ "$CR_TARGET" = "4" ]; then
	echo "Exit"
	exit
else
	DEVICE_DIR
	CHECK
	FLASH
fi