class MidiMacroBridge < Formula
  desc "Translate MIDI events into keystrokes/macros for DAW integration"
  homepage "https://github.com/audiocontrol-org/audiocontrol"
  license any_of: ["MIT", "Apache-2.0"]
  version "0.3.2"

  on_macos do
    on_arm do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "694f58d8c8a2c8783d0965bf7885d84d93d94ec46621f07fa4a57092f11507f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/audiocontrol-org/audiocontrol/releases/download/v#{version}/midi-macro-bridge-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3fa6ba88d52a6c72c75a01082728776df2ca2decab5d196cf6a52336a4399390"
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
