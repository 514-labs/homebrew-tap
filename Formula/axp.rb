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
  version "0.5.1246-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1246-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "86d6511c2aba3659ba7b8a59328ada759bac92945015a94c879bdf2fcc6de93b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1246-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1178c3c140034bcffe703f8d77a5a6a969784f4a5a26dd46a81fda27e8ce9f17"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1246-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "51154b58d04290e37d97ccefb69aca50cf86cdd0fa04f4866e68b7aedb0b3f70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1246-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b99e3792f33fba3a1e1cab1f995433db4a9fd23bffbb91f1e3f1ee2dc14e6921"
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
