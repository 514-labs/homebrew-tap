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
  version "0.5.1607-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1607-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "802586a2cc2ef519aad791d72c4224095fe1b7d9202a94b862a28bc0a33fc2c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1607-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1f59930acaf6282d3f69b47dbaec20ce71dfd17b3e7ede5bd70eb43e8e4725f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1607-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "92a43273245f5a46ae8502c8d5e33f639b28b1091bbce62e592b3bfc97a140bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1607-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "66b2ad1d303f1894af4f95e1a0df001607e9392964f66446247f4aadee49a32f"
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
