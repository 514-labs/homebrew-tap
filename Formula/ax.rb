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
  version "0.5.587-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.587-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4c3e05be715cd1ec8351e086b7ca262a184153218828b63d7d7a4d7a8b2c11df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.587-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1044bcf21a8addad02c020d947a1ff1718df90ad960d5687796033dd60900a49"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.587-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4f4e877aec910c75332befd0a19c059468275212b7cf7649863d1aa49410c0fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.587-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86d2a5a1c5974f7de39dd585a6383c9276f8b1e42c986e6d90ac003415183ea6"
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

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
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
