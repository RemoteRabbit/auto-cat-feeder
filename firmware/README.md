# Firmware

Firmware for the ESP32-S3 on the control board. Not started yet.

## Toolchain

TODO: pick one (ESP-IDF, PlatformIO, or Arduino) and document the version.

## Build and flash

```sh
# TODO
```

To enter the bootloader manually, hold **BOOT**, press **RESET**, then release **BOOT**.

## Configuration

Wi-Fi credentials and other secrets go in a local `secrets.h`, which is ignored by git. Copy `secrets.example.h` to start.

TODO: list the settings.

## Behavior

TODO:
- Feeding schedule and portion size
- TMC2209 setup over UART (current, microstepping, StallGuard)
- Jam detection and recovery
- What happens after a power loss
- OTA updates and remote control
