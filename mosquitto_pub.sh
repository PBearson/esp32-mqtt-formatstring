a1="a046fb3f"
a2="44434241"

a1_bin=$(echo $a1 | xxd -p -r)
a2_bin=$(echo $a2 | xxd -p -r)

mosquitto_pub -h localhost -p 1883 -t \
    "/topic/qos0" -m "$a1_bin$a2_bin %x %x %20x %n %x"