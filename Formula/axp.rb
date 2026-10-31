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
  version "0.5.1567-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1567-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2376915acf531e85bfbec1839ab512e6b70de6db4d2ce7c44cf0dcbb3c312ca3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1567-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "152a95e2f609c433d3679820caba4781b2ad1634e779c4696f43e9815a53939b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1567-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "12aa78dbe64252c65fb5e66b7e07e8e7c0b6e5fc51445d4fa7e5356c8a4b9a78"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1567-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7611e80b614488774bfe0b6c4b038cbc8adf34444d37823056aafcf6f135ffb1"
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
