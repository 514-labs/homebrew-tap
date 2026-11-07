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
  version "0.5.1680-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1680-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "254266471a035d39c9227ba6fe9b3bbd680ff714b13f1218cdfa2e11637e6c04"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1680-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1814c489a5c25fb155c0157c9e4c1d58823c20008ba2b04a74050bf2412f826c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1680-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "39c8bfefe55543d1295dca4d9ec035e04a0400cf69726c4f081393e50cea20fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1680-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "058727d0023bd014f3825289b51b4b3f70b1d251fdd83142434317364239df95"
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
