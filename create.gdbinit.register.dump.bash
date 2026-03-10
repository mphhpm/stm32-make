 #!/bin/bash
# create gdbinit H5 register dump
# file containing the adress of the registers
# 
# $1
#   <name> = <hex addr>
# e.g.
#    TR = 0x044
#
# $2
#    name of the ressource
#  e.g.
#    RTC
#
# $3
#    base address to be used, see .gdbinit.stm32H5
#  e.g.
#    $RTC
#
# bash ./create.gdbinit.register.dump.bash rtc.address.H5.txt RTC '$RTC'  > .gdbinit.stm32H5.RTC
#
echo "#"
echo "# print $2 registers"
bash ./create.gdbinit.addr.var.bash $1
echo 
echo "#"
echo "define print_"$2
echo "#"
echo "#"
cat $1 | sed -e 's@,@@g'  -e 's@ @@g' -e 's@\t@@g'  -e 's@=@ @g' | sort | awk -v UNIT=$2 -v BASEADDR=$3 '{ print "\tset $addr = "BASEADDR" + $"$1"\n\tset $name = \""$1"\"\n\tprintf \""UNIT".%-8s 0x%4x %4x: 0x%08x\\n\", $name, ($addr >> 16), ($addr & 0xFFFF), *$addr\n"}' 
echo end 