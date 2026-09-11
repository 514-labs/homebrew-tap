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
  version "0.5.1011-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1011-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3a5c69ab02cbc0bc1a945d0b28716b62d6cbe122f0a7f1fdf5cfb4048431ab89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1011-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e706ac659aee9102d0adb30a6f46ae7a84032159bf58644e835906daa017354a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1011-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ceef3a126f59db9eca76d372499216cd178e0efa6e9431c31b20507be9627e4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1011-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "607f05c51da3a3ec9cc8e989a0316f72e92d7b725fc299ea93cd9ec30658521d"
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
