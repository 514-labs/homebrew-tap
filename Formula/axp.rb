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
  version "0.5.1349-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1349-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fa66e25b503238db9a0c666ac4da3ac0eb68eb55c7c2dc23d4f7acbe818b64e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1349-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4f7af5d8477bd65fd0dcefe2ca09df38b5d293199c302346aa57b2492eaab56b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1349-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4784c54dadab63ce64419f8a71ee78ed73d4ed2501a6721379dfff29f85a9d64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1349-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3c07b08daf584e48a03d0c0d69d4e875326d48b880c8506c7d8cc4caf9b693db"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
