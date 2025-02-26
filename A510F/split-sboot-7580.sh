# input file argument : sboot.bin - A510FXXS8CTI7 - sha1sum: 466852d13fa02d51729d21633f47708308579f58
dd if=$1 of=fwbl1.bin skip=0 bs=512 count=16 # 0x2000 @ 0x0 fwbl1
dd if=$1 of=el3_mon.bin skip=16 bs=512 count=384 # 0x30000 @ 0x2000 el3_mon
dd if=$1 of=bl2.bin skip=204800 bs=1 count=32016 # 0x7d10 @ 0x32000 bl2
dd if=$1 of=bootloader.bin skip=464 bs=512 count=1672 # 0xD1000 @ 0x3A000 bootloader
