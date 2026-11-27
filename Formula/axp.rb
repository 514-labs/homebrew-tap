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
  version "0.5.1799-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1799-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1f6b9183c7d64163a72481d47ac793fccb4eaa501b18e985eca7e7f21adb6bce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1799-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "042ed1c29a42b34b65da42374c42baba84aabdfa4d7f13522595a8ad3ba742ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1799-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "73cfe51f344bcadd26be9c88385e645176a525fcbd35b926882dfa51976f7e8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1799-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5a9510d3f380e338c976fa2230da2b2ed78f9d6c0a3ec3541c2b6ef2fc2717ac"
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
