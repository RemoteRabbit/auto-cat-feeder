# Automatic Cat Feeder Project

An ESP32-S3 based automatic cat feeder: a stepper motor driven by a TMC2209 dispenses food on a schedule. The feeder is powered over USB-C Power Delivery.

<!-- TODO: photo or render of the feeder -->

## Status

Work in progress. The PCB schematic and layout are underway, the enclosure is being modeled in FreeCAD, and the firmware has not been started.

## Features

- USB-C PD power (15 V negotiated by a CH224A)
- TMC2209 stepper driver for quiet dispensing
- ESP32-S3 with Wi-Fi for scheduling and remote control
- TODO: feeding schedule, portion control, jam detection, notifications

## System overview

```
USB-C PD ──▶ CH224A ──▶ +15V ──┬──▶ TMC2209 ──▶ Stepper (dispenser)
                               └──▶ AP63205 buck ──▶ +5V ──▶ AMS1117 ──▶ +3V3 ──▶ ESP32-S3
```

## Repository layout

| Path        | Contents                                         |
|-------------|--------------------------------------------------|
| `pcb/`      | KiCad project for the control board              |
| `models/`   | FreeCAD models of the enclosure and mechanism    |
| `firmware/` | ESP32-S3 firmware                                |
| `docs/`     | Assembly, wiring, and hardware documentation     |

## License

TODO: choose licenses (for example CERN-OHL for hardware, MIT for firmware).
