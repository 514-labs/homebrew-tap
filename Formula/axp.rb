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
  version "0.5.1648-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1648-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d8872955f6a07dcbb71d025855ee07b3fd2d5a09f04b84383d527d5fe9efc9b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1648-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ef2459aaaaefadf5bbe98276dbfb09353a7f24cb36580c05a564261ef1c35286"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1648-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c73c9a52e69bbd10fac22b43d363d1d8e10763aeccabc8d9d2a6fb362a2802a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1648-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "39e3a0dae580e922a40da7fe1d1c56ba572a66e9f245d061a904f8bd38ce1a46"
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
