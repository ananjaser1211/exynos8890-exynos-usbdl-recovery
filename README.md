# [Exynos8890 Recovery](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery) - Re-flashing SBOOT via exynos-usbdl Mode
 Galaxy S7 / S7 Edge Exynos Bootloader recovery/unbrick through exynos-usbdl

## Description
- Exynos devices support a flash mode caled "exynos-usbdl" which is triggered when Main Stage (UFS) Boot fails, a common scenario to fall into this mode is a bad bootloader flash (sboot.bin or cm.bin) or UFS Damage. these files will help you Recovery from that mode and "Unbrick" your phone aslong as the UFS Chip is *NOT* actually damaged.

- So basically this post is about Attempting to unbrick bootloader on Galaxy S7 and S7 Edge Exynos8890.

- Also a way to document everything i can find about this mode and the various ways to recover from it.

- This is NOT a bulletproof un-bricker, sometimes re-enumurating / re-connecting to the device fails and causes the 4th binary to not be flashed, Trial and error is needed

## Requirments to qualify for this Unbrick
There are few things to tell if you are in USB-DL. here are my observations . All of them need to be met to be able to use this repo :

- Your phone does not show LPM (Powered off charging) when plugged to AC outlet

- Your phone does NOT boot to either OS / Bootloader or Recovery (even when performing BL Combo `Power + Vol Down + Home`)

- Your device is detected for one second only on a windows machine once plugged via USB

- And most importantly **Holding POWER button** Will allow the phone to be detected in Windows Device Manager

- When inspecting devices in Device Manager while the **POWER** Button is held, Exynos8890 will show up in devices.

![image](https://user-images.githubusercontent.com/25624482/234079282-18fb0dc5-6f18-4e70-a6d0-94411ba36208.png)

- Luck

## Supported Devies
- SM-G930F
- SM-G935F

* Other devices can be supported by finding proper offsets, if/when i find information on how to calculate said offsets i will update this

## Boring Details
- There exists a tool called "MultiDownloader" which is capable of flashing binaries in usb-dl Mode.
- The tool only runs on Windows, However there are open source implementations see : [exynos9610-usb-emergency-recovery](https://github.com/astarasikov/exynos9610-usb-emergency-recovery) 
- In this guide, the windows tool will be used, alongside "ImageWriterUSBDriver_1113_00"
- The Tool is old and drivers originate from [Motorolla-BlankFlash](https://mirrors.lolinet.com/firmware/motorola/troika/blankflash/) which are [mirrored here](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery/releases/tag/usb-dl)
- `SBOOT.BIN` is made of multiple binaries at different offsets, [split-sboot-8890](https://github.com/frederic/exynos-usbdl/blob/master/scripts/split-sboot-8890.sh) was used to strip them out of the `SBOOT.BIN` binary.
- Currently only SM-G930F And SM-G935F Binaries / config is uploaded as these are the only two i was able to test myself however it should be possible to split S/L/K Variants and SM-N930F/SM-N935F `S-BOOT.BIN` to use with this guide.
- **No, Downgrading BOOTLOADER Version likely does not work due to the rollbak bit. the binaries in this post are G930FXXU8ETI2/G935FXXU8ETI2 with Rev 8**

## So how to Recover ?
- If your phone is actually stuck in USB-DL and has no hardware Fault, Then the recovery is as follows :

1- Download the attached Binaries from [Here](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery/releases/tag/usb-dl) or the source [here](https://mirrors.lolinet.com/firmware/motorola/troika/blankflash/)

2- Download this reposity as a ZIP and extract it

3- Install `ImageWriterUSBDriver_1113_00.exe` Drivers

4- Lunch `Multidownloader_64bit_1.4.1.exe`

5- Press the 3 Dots and select the appropriate config for your device. **exynos-usbdl_g930f.cfg** or **exynos-usbdl_g935f.cfg**

6- Plug your device

7- Hold the **POWER** Key and confirm your device is detected by checking Device Manager

8- Your Device should show up in multidownloader

![image](https://user-images.githubusercontent.com/25624482/234083783-86e231b6-8289-4bda-9e5e-8d05d02445f0.png)

9- Press **Start** and wait, flash takes few seconds. keep the **POWER** button held at all times

![image](https://user-images.githubusercontent.com/25624482/234083831-9d5323da-37ff-4151-af96-38fccaf53519.png)

10- **It will fail the first 2/3 times**, Repeat the process by starting again

- Images on My SM-G935F reference - First two flashes Faild, 3rd one was succesful (Note : It wont show last stage)

![image](https://user-images.githubusercontent.com/25624482/234087087-1c88540a-032e-40b1-b6f7-e64f1d436bb4.png)

11- Once your phone stays connected while releasing the **POWER** Button or stops showing up in MultiDownloader, The flash was successful.

12- Now you should be able to Hold download mode combo `Power + Vol Down + Home` and boot into DownloadMode

13- After which you can download your stock firmware from [SamLoader](https://github.com/zacharee/SamloaderKotlin) / [SamFW](samfw.com) and follow various other guides online on how to flash your phone via ODIN Or heimdall

- **Note :** Since my S7 was bricked a couple times, on some occaisons i had to take the back cover off and physically disconnect the battery after flashing to reset the board. However holding `Vol DOWN + Power` for 15 seconds should trigger a force reboot

## Credits and sources
- https://fredericb.info/2020/06/exynos-usbdl-unsigned-code-loader-for-exynos-bootrom.html

- https://github.com/frederic/exynos-usbdl

- https://github.com/astarasikov/exynos9610-usb-emergency-recovery

- https://forum.xda-developers.com/t/guide-repair-hard-bricked-devices-with-deleted-bootloader-sboot.3573865/
