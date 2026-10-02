#!/bin/sh
set -eu

# Always run from the repository root, including when invoked elsewhere.
cd "$(dirname "$0")/.."
cargo build --release --locked
mkdir -p build
cp target/riscv32imac-unknown-none-elf/release/example-repo-embassy build/firmware.elf
cat > build/dasahi-result.json <<'JSON'
{
  "schemaVersion": 1,
  "artifacts": [
    {"name": "firmware", "path": "firmware.elf", "kind": "firmware", "chip": "esp32c6"}
  ],
  "reports": []
}
JSON

