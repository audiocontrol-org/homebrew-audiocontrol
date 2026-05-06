# audiocontrol Homebrew tap

Homebrew tap for [audiocontrol](https://github.com/audiocontrol-org/audiocontrol) tools.

## Tap

    brew tap audiocontrol-org/audiocontrol

## Available formulas

### midi-macro-bridge

Translate MIDI events into keystrokes / MCU control-surface output for DAW integration.

    brew install midi-macro-bridge

Run interactively:

    midi-macro-bridge

Or as a background service:

    brew services start midi-macro-bridge

See the [project README](https://github.com/audiocontrol-org/audiocontrol/tree/main/services/midi-macro-bridge) for configuration and usage.

## Platforms supported

| Formula | macOS arm64 | Linux x86_64 |
|---|---|---|
| midi-macro-bridge | ✅ | ✅ |

Other platforms (Intel Mac, Linux arm64, musl) are out of scope for v1.

## Notes

Formulas in this tap install pre-built bottles from
[audiocontrol GitHub Releases](https://github.com/audiocontrol-org/audiocontrol/releases) —
not from source. Each release publishes per-platform tarballs with `.sha256`
files and an aggregate `SHA256SUMS`; the formula's `sha256` fields are
synced from `SHA256SUMS` via the
[`update-homebrew-formula.sh`](https://github.com/audiocontrol-org/audiocontrol/blob/main/services/midi-macro-bridge/scripts/update-homebrew-formula.sh)
helper in the audiocontrol repo.
