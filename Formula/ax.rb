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
  version "0.5.291-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.291-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15b4152ef53fcedb816394feef2ded25130b3d566a89a0ff4056389eb5cfa75c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.291-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "84e90539bc4cc6c951ef9a38a0a58bbc3793fe8c36e4e65abf0267d77dc14d7b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.291-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "68786ff7d066e33c5bd977c9fc9593a8a9c7176169dca0efb750438d672ba24f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.291-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aff4470e22aebd9a95ce0f26de94c75b2f2c3743261f795cd62b00049f079048"
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

      Create and run your first experiment:
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
