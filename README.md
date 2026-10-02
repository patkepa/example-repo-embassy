# ESP32-C6 Embassy example

Minimal bare-metal Rust firmware for ESP32-C6: prints
`Hello world from ESP32-C6 Embassy! tick=0` and an increasing tick once per second.
Uses Embassy async timers and the esp-rtos Embassy executor. No Wi-Fi, heap,
GPIO wiring, or board-specific LED required.

Logs use the chip's native USB Serial/JTAG port (115200 baud, plain text).
Connect the board's native USB port; a separate UART adapter will not receive
these application logs. Works with boards such as the Seeed XIAO ESP32-C6.

## Build

Install Rust with rustup, then run:

```sh
sh scripts/build.sh
```

`rust-toolchain.toml` pins Rust 1.96.0 and the RISC-V target; `Cargo.lock` pins
dependencies. Outputs are `build/firmware.elf` and `build/dasahi-result.json`.
Builds require no attached hardware or ESP-IDF installation.

## Flash and monitor

Install [espflash](https://github.com/esp-rs/espflash), connect an ESP32-C6, then:

```sh
cargo install espflash --locked
cargo run --release --locked
```

## Dasahi pipeline

Add `https://github.com/patkepa/example-repo-embassy` with branch `main` and
manifest path `.dasahi/pipeline.yaml`. The build step uses the official
`rust:1.96.0-bookworm` container, installs the RISC-V target, and runs the same
build script. The runner needs network access to pull the image and download
the target and crates on its first build.

Dasahi imports the named `firmware` artifact as an ESP32-C6 ELF; result paths
are relative to `build/dasahi-result.json`. The pipeline builds only. A hardware
profile can be bound later for flashing and a serial assertion matching
`Hello world from ESP32-C6 Embassy!`.

Runtime setup follows the [esp-rtos Embassy documentation](https://docs.espressif.com/projects/rust/esp-rtos/0.3.0/esp32c6/esp_rtos/index.html).
