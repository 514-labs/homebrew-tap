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
  version "0.5.1727-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1727-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6bc05df071bdf9cd36bb615c034f0c1898158c0d5b864a91c4e4d961d29adba8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1727-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "06695c009dc399fba7c96ce02ce061f190701c450ab191bd13db28a7eb67e043"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1727-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e72f736d8320f11a40d2799d0dcb41faaebf13a0bc93434b5f699dd4ed9c81b8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1727-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d1e08d89347ca32773ca3f38ebd442b465a6b660f7037d34149f79ba3936fdb5"
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
