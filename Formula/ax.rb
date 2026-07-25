# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.448-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.448-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "785e1119b6266cc21c4171e33b61f1cfa046b8490673837d142ad2d566e5c116"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.448-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ee75e30abb4afcb2ebdade32b52744e5dbf22200e882afc5ce4d2a4305289eb3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.448-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3ccbc51efba81fffb31ebc198ea2910b68e9d94b66c17fe9df9d77da93001ad6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.448-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "35618e3044f7753fe273ede7143db731ec9153c5d0a42f50f354991d99ed1b1f"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
