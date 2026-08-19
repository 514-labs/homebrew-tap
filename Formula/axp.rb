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
  version "0.5.831-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.831-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "84711e274fd6fdd64eb6f624221be83077fbd6f8fe8c593c00aceb3816eb2f2a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.831-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2e795a6327c119edcd0b6528d8ca6684c59100e95a990c22b5a87783c20b6bf0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.831-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cf0566f869ee58a98af56fc8ce4148d5405fda688f6c784ef2b2ff652893a28e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.831-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9e95418b2970834ac530568db8d7509c4a6e4d4f8245902eec2778d011f9857e"
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
