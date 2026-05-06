class MidiMacroBridge < Formula
  desc "Translate MIDI events into keystrokes/macros for DAW integration"
  homepage "https://github.com/audiocontrol-org/audiocontrol"
  license any_of: ["MIT", "Apache-2.0"]
  version "0.3.1"

  on_macos do
    on_arm do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "c57a4e47fca1ae86bf277a592e636fe1a7ab693f9aec92280c3e348f3a776030"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "658a0d44498b13ea4673633e400d336fa15324c3c24cabfa357b745b3a6691c1"
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
