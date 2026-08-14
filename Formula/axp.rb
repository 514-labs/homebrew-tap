# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.790-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.790-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "405917d3364c91cc2cbf8ec17b6c483f4288090ee95935adaa507d26e2c4aef4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.790-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "00f903964d5d98c0208d5262f6aa477eb2680401163103e271bc61e564931123"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.790-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f72fd42e4f7f86cfaa81858ba4f8b62a43cacff88bb96910f0f83abcf4318bbd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.790-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8d40d71033bae2ea6746ac66f18d27072821d5fb0986f1e1e6fae550c3878e0e"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
