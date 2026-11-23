# Control Board (PCB)

Two-layer control board for the cat feeder, designed in **KiCad 10.0**.

Open `all.kicad_pro`. The top-level sheet is `all.kicad_sch`, and it has two sub-sheets:

- `power-delivery.kicad_sch`: USB-C PD input and the power rails
- `esp32-s3.kicad_sch`: microcontroller, stepper driver, and connectors

## Key parts

| Function         | Part               | Notes                                  |
|------------------|--------------------|----------------------------------------|
| MCU              | ESP32-S3-WROOM-1   | BOOT and RESET buttons on board        |
| Stepper driver   | TMC2209-LA         | 0.11 Ω sense resistors                 |
| USB-C PD sink    | CH224A             | Requests 15 V                          |
| 5 V buck         | AP63205WU          | 4.7 µH inductor                        |
| 3.3 V LDO        | AMS1117-3.3        |                                        |
| USB ESD          | USBLC6-2SC6        |                                        |
| Input protection | SMAJ18A TVS, 2 A polyfuse |                                 |

## Power rails

| Rail  | Source       | Used by       |
|-------|--------------|---------------|
| +15V  | USB-C PD     | TMC2209 motor supply (VS), AP63205 buck |
| +5V   | AP63205 buck | AMS1117 (powers the ESP32-S3), USBLC6 VBUS reference |
| +3V3  | AMS1117      | ESP32-S3, TMC2209 logic (VCC_IO), pull-ups |

TODO: current budget per rail.

## ESP32-S3 pinout

| GPIO   | Module pin | Net        | Connects to         | Notes |
|--------|-----------:|------------|---------------------|-------|
| EN     | 3          | ESP_EN     | RESET button (SW1)  | 10k pull-up to 3V3, 1 µF to GND |
| IO0    | 27         | ESP_BOOT   | BOOT button (SW2)   | Strapping pin; hold low at reset for download mode |
| IO4    | 4          | TMC_STEP   | TMC2209 STEP        | |
| IO5    | 5          | TMC_DIR    | TMC2209 DIR         | |
| IO6    | 6          | TMC_EN     | TMC2209 ~EN         | Active low; 10k pull-up keeps the driver off at boot |
| IO7    | 7          | TMC_DIAG   | TMC2209 DIAG        | StallGuard / fault output |
| IO8    | 12         | PD_PG      | CH224A PG           | Open-drain with 10k pull-up; CH224A pulls it low once PD negotiation succeeds |
| IO17   | 10         | TMC_TX     | TMC2209 PDN/UART    | UART TX through 1k (R9) |
| IO18   | 11         | TMC_UART   | TMC2209 PDN/UART    | UART RX, direct (single-wire UART) |
| IO19   | 13         | USB_DN     | USB-C D−            | Native USB, ESD-protected by USBLC6 |
| IO20   | 14         | USB_DP     | USB-C D+            | Native USB, ESD-protected by USBLC6 |

Unused: IO1–3, IO9–16, IO21, IO35–42, IO45–48, TXD0, RXD0. IO35–37 are taken by octal PSRAM on some WROOM-1 variants.

The TMC2209 has MS1 and MS2 tied to GND, so its UART address is 0.

The stepper connector (J2, JST 6-pin) uses pin 1 = A1, pin 3 = A2, pin 4 = B1, pin 6 = B2. Pins 2 and 5 are not connected.

## Bill of materials

Open `bom/ibom.html` in a browser for the interactive BOM. Regenerate it after board changes.

## Fabrication

Fabrication outputs are generated with the Fabrication Toolkit plugin, using the settings in `fabrication-toolkit-options.json`. Outputs are not committed.

TODO: fab house, stackup, thickness, finish, and assembly options.

## Revisions

| Rev  | Date | Changes | Known issues |
|------|------|---------|--------------|
| v0.1 | TODO | Initial design | TODO |
