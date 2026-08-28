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
  version "0.5.925-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.925-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c0941b249f26cf505dda179c99e1757c89e6c26855a50451c4361b1d96cb97a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.925-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f921e06d411a5eca5cee5a53b6fb324b869ec5bb2b8716ee47bf2113256fd23a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.925-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e3b9b9b5e55c9c117ef4c3824c95d55d2e06e6e22c7fa375729d668f04705b33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.925-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "041ac89076aa5c50486b0879ffaadfaea2a3985cb60df6f9234cda7d31c50211"
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
