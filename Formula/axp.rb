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
  version "0.5.1231-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1231-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "24de16d911def2a095a69a6f5b0c042a811d958ca7b61598258edc1962b9d140"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1231-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "25eae2b2814003fca01c3a864a4d0ec268d8052c5121ade81b3f9f5098a9404d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1231-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "510e08a9f2a513818a4b2a5bdaafd7da21bd6668ba26566576a3270e273ca84a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1231-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "642fb570a4e614cd92525ee8253e3cdf96c5708256ae8ad6ba753d0deb0f6bed"
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
