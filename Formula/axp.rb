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
  version "0.5.1547-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1547-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c10fbd75528b742c1c39bad1b8e94d08d1ee043cc0826676ec98f81b316f15bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1547-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bed5cd9284ebf6154020e8e1f9d2528956888e585baf0b25edb3299c37b36020"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1547-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef6cb1571c45c7289c59b8e59902442eced05799c3404904f9acca2284759bac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1547-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d5fbe3f50f5f7213c27a52d38784d554bf8d0053614b34e64db7e231e333482"
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
