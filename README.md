# [Exynos8890 Recovery](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery) - Re-flashing SBOOT via exynos-usbdl Mode
 Galaxy S7 / S7 Edge Exynos8890 / A5 2016 Bootloader recovery/unbrick through exynos-usbdl

## Description
- Exynos devices support a flash mode caled "exynos-usbdl" which is triggered when Main Stage (UFS) Boot fails, a common scenario to fall into this mode is a bad bootloader flash (sboot.bin or cm.bin) or UFS Damage. these files will help you Recovery from that mode and "Unbrick" your phone aslong as the UFS Chip is *NOT* actually damaged.

- So basically this post is about Attempting to unbrick bootloader on Galaxy S7 and S7 Edge Exynos8890.

- Only Tested on G930F and G935F - Other variant binaries are not tested

- Also a way to document everything i can find about this mode and the various ways to recover from it.

- This is NOT a bulletproof un-bricker on Windows, sometimes re-enumurating / re-connecting to the device fails and causes the 4th binary to not be flashed, Trial and error is needed

- **Recommended : A linux computer to run fredric exynos-usbdl flasher instead of MultiDownloader**

## Requirments to qualify for this Unbrick
There are few things to tell if you are in USB-DL. here are my observations . All of them need to be met to be able to use this repo :

- Your phone does not show LPM (Powered off charging) when plugged to AC outlet

- Your phone does NOT boot to either OS / Bootloader or Recovery (even when performing BL Combo `Power + Vol Down + Home`)

- Your device is detected for one second only on a windows machine once plugged via USB

- And most importantly **Holding POWER button** Will allow the phone to be detected in Windows Device Manager

- When inspecting devices in Device Manager while the **POWER** Button is held, Exynos8890/Exynos7580 will show up in devices.

![image](https://user-images.githubusercontent.com/25624482/234079282-18fb0dc5-6f18-4e70-a6d0-94411ba36208.png)

## Supported Devies and binary version
- SM-A510F - A510FXXS8CTI7 [ Only tested on Linux ]
- SM-G930F - G930FXXU8EVH2
- SM-G935F - G935FXXU8EVH3
- SM-N935F - N935FXXU8CVG2 [ Un-tested ]

* Other devices can be supported by finding proper offsets, if/when i find information on how to calculate said offsets i will update this

## Boring Details
- on Windows we can use a tool called "MultiDownloader" + "ImageWriterUSBDriver_1113_00" to flash in usbdl mode
- exynos-usbdl is a tool created by [@frederic](https://github.com/frederic) as part of an s-boot exploit, However we can use it to recovery from usb-dl much more consistently than windows, see [exynos-usbdl](https://github.com/frederic/exynos-usbdl)
- The Tool is old and drivers originate from [Motorolla-BlankFlash](https://mirrors.lolinet.com/firmware/motorola/troika/blankflash/) which are [mirrored here](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery/releases/tag/usb-dl)
- `SBOOT.BIN` is made of multiple binaries at different offsets, [split-sboot-8890](https://github.com/frederic/exynos-usbdl/blob/master/scripts/split-sboot-8890.sh) was used to strip them out of the `SBOOT.BIN` binary.
- Currently only SM-G930F, SM-G935F and SM-A510F are tested. it should be possible to split other variant's `S-BOOT.BIN` to use with this guide.
- **No, Downgrading BOOTLOADER Version likely does not work due to the rollback bit. the binaries in this post are most recent Rev 8 binaries**

## Credits and sources
- [@frederic](https://github.com/frederic) for their exynos-usbdl project and research

- https://fredericb.info/2020/06/exynos-usbdl-unsigned-code-loader-for-exynos-bootrom.html

- https://github.com/frederic/exynos-usbdl

- [@jeykul](https://github.com/JeyKul) for bricking their G930F to test

- https://github.com/astarasikov/exynos9610-usb-emergency-recovery

- https://forum.xda-developers.com/t/guide-repair-hard-bricked-devices-with-deleted-bootloader-sboot.3573865/

## Linux Instructions

- If your phone is actually stuck in USB-DL and has no hardware Fault, Then the recovery is as follows :

1- Download this repo as a [zip](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery/archive/refs/heads/main.zip) or use `git clone https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery`

2- Open a linux terminal window in the downloaded folder, or `cd exynos8890-exynos-usbdl-recovery`

3- Plug your device via USB.

4- Execute the recovery script as root `sudo ./exynos-usbdl-recover.sh`

![image](https://user-images.githubusercontent.com/25624482/234318977-40fa020a-8f3c-4740-99a8-5869373c8af5.png)

5- Select your device from the window and hit enter.

6- The script will perform few checks and then Flashing process will start as soon as you hit enter again. When the power button is held for a long time, the connection resets. Sometimes it helps to look at `dmesg -w` and hit enter just after the `Manufacturer: System MCU` message appears in the terminal.

![image](https://user-images.githubusercontent.com/25624482/234319135-e28b827c-bf88-4528-80b0-2bf084ab7f5b.png)

7- Once it says `Start Flashing` hold the POWER Key and keep it held.

8- if you get `Error: cannot open device 04e8:1234` that means your device is not in USBL-DL or you did not hold the powerkey long enough.

9- if everything goes well, Your device will reboot into Download Mode once it is successful. You wont have to press any additional buttons.

10- you can download your stock firmware from [SamLoader](https://github.com/zacharee/SamloaderKotlin) / [SamFW](samfw.com) and follow various other guides online on how to flash your phone via ODIN Or heimdall

- Reference Video of usb-dl courtusy of [@jeykul](https://github.com/JeyKul)

https://user-images.githubusercontent.com/25624482/234320219-ded8ef1b-2d7e-4fc9-8af6-71f2b8427573.mp4

## Windows Instructions

** Note : Try to use Linux version instead as Multidownloader fails alot at the last step **

- If your phone is actually stuck in USB-DL and has no hardware Fault, Then the recovery is as follows :

1- Download the attached Binaries from [Here](https://github.com/ananjaser1211/exynos8890-exynos-usbdl-recovery/releases/tag/usb-dl) or the source [here](https://mirrors.lolinet.com/firmware/motorola/troika/blankflash/)

2- Download this reposity as a ZIP and extract it

3- Install `ImageWriterUSBDriver_1113_00.exe` Drivers

4- Lunch `Multidownloader_64bit_1.4.1.exe`

5- Press the 3 Dots and select the appropriate config for your device. **exynos-usbdl_g930f.cfg** etc.

6- Plug your device

7- Hold the **POWER** Key and confirm your device is detected by checking Device Manager

8- Your Device should show up in multidownloader

- **Note : Throughout this entire process, the power button MUST BE HELD otherwise you leave usb-dl mode**

![image](https://user-images.githubusercontent.com/25624482/234083783-86e231b6-8289-4bda-9e5e-8d05d02445f0.png)

9- Press **Start** and wait, flash takes few seconds. keep the **POWER** button held at all times

![image](https://user-images.githubusercontent.com/25624482/234083831-9d5323da-37ff-4151-af96-38fccaf53519.png)

10- **It will fail the first 2/3 times**, Repeat the process by starting again

- Images from My SM-G935F for reference - First two flashes Faild, 3rd one was succesful (Note : It wont show last stage) and wont mention **Write failed**

![image](https://user-images.githubusercontent.com/25624482/234087087-1c88540a-032e-40b1-b6f7-e64f1d436bb4.png)

11- Once your phone stays connected while releasing the **POWER** Button or stops showing up in MultiDownloader, The flash was successful.

12- Now you should be able to Hold download mode combo `Power + Vol Down + Home` and boot into DownloadMode

13- After which you can download your stock firmware from [SamLoader](https://github.com/zacharee/SamloaderKotlin) / [SamFW](samfw.com) and follow various other guides online on how to flash your phone via ODIN Or heimdall

- **Note :** Since my S7 was bricked a couple times, on some occaisons i had to take the back cover off and physically disconnect the battery after flashing to reset the board. However holding `Vol DOWN + Power` for 15 seconds should trigger a force reboot
