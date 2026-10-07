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
  version "0.5.1272-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1272-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8a2379549378460fba99fa4f5193d00b5e19f809d2402f3c4ebc75d3647b1d69"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1272-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e6d22967ea62c68488f2776023badfe8b438aef1fe6ec4e9429951cbce458592"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1272-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9b9a71ae9bc422df3c5a85819d038daa8fbfcd46dccbd640f209740a6e7ca3f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1272-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "66e74dbab59124de56c3f4bbfad405952de93753900023de9cbadbc77caac5cb"
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
