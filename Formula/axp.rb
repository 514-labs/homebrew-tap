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
  version "0.5.1312-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1312-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4f4de988122265967ca14a8124b1ed4fec028dca1479253cae32ae50995b837b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1312-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1bb0407fa5175a856736ff08c92a2225ba349e540a53ec236715e63eca6e2225"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1312-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "38b5ace987f0814e47e40571283265ce4c35c58af267b871e103cee347efed27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1312-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3ec000e0fa2650b3626c0ff7e092e996889bf74f65ca24296e286cce9db4b101"
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
