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
  version "0.5.1786-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1786-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a1057f083bc7ff942afa4eeb6d93bfbee46caf25d9f4252874c2e32c2d44ea5b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1786-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "677e379e1ad7b1cdd4db6618b27a8f1159f126f7a60d73b22a701abe631217ed"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1786-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4e6195c26f433e396f7c129a11a788359e5916d252d417c92eaa62a551726e10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1786-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a3e123a9010a570736039b45671d3f09677b9c0abd307986774ba57b09b289d"
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
