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
  version "0.5.1233-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1233-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "52e50a2f6822bd61b836bea72e7ad42b98af8342d6d42b5871747b427d40d386"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1233-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "49a03d3638a081d44dadd495bed50cd352b2d097cc52a7de195439ee6074b931"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1233-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "daa27bc4072661233f76ce5dfc34d7762825a628362ddcb4805efe51efc2e0b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1233-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "21c4dc40d4866037e35ac2e7f813dd24d48ffd378ca928b1e3ed72ddd5973cf4"
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
