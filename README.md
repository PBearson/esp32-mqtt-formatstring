# ESP32 MQTT Format String

## Introduction

TODO

## Crashing the Program

```
. mosquitto_pub.sh crash
```

![Crashing the program](images/mqtt_crash.JPG)

## Reading the Stack

```
. mosquitto_pub.sh readstack
```

![Reading the stack](images/mqtt_reading_stack.JPG)

## Reading Arbitrary Memory

```
. mosquitto_pub.sh readmem
```

![Reading arbitrary memory](images/mqtt_reading_arbitrary_memory.JPG)

## Writing Arbitrary Memory

```
. mosquitto_pub.sh writemem
```

![Writing arbitrary memory](images/mqtt_writing_arbitrary_memory.JPG)

## Control Flow Hijack

```
. mosquitto_pub.sh hijack
```

Overwriting the return address:

![Control flow hijack return address](images/mqtt_control_flow_hijack_return_address.JPG)

This new address points to ___abort()___:

![Control flow hijack abort](images/mqtt_control_flow_hijack_abort_disas.JPG)

Performing the attack:

![Control flow hijack](images/mqtt_control_flow_hijack.JPG)

## Code Injection

```
. mosquitto_pub.sh inject
```

Overwriting the return address:

![Overwriting the return address](images/mqtt_code_injection_return_address.JPG)

The injected code is not too interesting when we monitor the output. Instead we show the injected assembly code at the target address:

![Code injection](images/mqtt_code_injection.JPG)
