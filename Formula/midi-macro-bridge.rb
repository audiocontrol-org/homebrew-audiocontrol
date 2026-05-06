class MidiMacroBridge < Formula
  desc "Translate MIDI events into keystrokes/macros for DAW integration"
  homepage "https://github.com/audiocontrol-org/audiocontrol"
  license any_of: ["MIT", "Apache-2.0"]
  version "0.3.3"

  on_macos do
    on_arm do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "86cab5e72c0aa64c45477c1115e3f45f987c1c9fa4326a2b72c08e5a8a65978c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f7f4995c19af5171b27d5b40bb564a19e9873f3e20f4d1eb3aee52afd001dc2c"
    end
  end

  def install
    bin.install "bin/midi-macro-bridge"
    pkgshare.install Dir["share/midi-macro-bridge/*"]
    doc.install Dir["doc/*"]
  end

  def caveats
    <<~EOS
      Configure with:
        mkdir -p ~/.config/audiocontrol/midi-macro-bridge   # Linux
        mkdir -p ~/Library/Application\\ Support/audiocontrol/midi-macro-bridge   # macOS
        cp #{opt_pkgshare}/config.example.toml \\
           <path-above>/config.toml

      Run interactively:
        midi-macro-bridge

      Or as a background service:
        brew services start midi-macro-bridge
    EOS
  end

  service do
    run [opt_bin/"midi-macro-bridge", "--no-open"]
    keep_alive true
    log_path var/"log/midi-macro-bridge.log"
    error_log_path var/"log/midi-macro-bridge.log"
  end

  test do
    # The binary doesn't yet have a --help flag (TODO upstream); --list-ports
    # exits cleanly after enumerating MIDI inputs. `system` fails the test if
    # the binary exits non-zero, so the bare invocation is the test.
    system bin/"midi-macro-bridge", "--list-ports"
  end
end
