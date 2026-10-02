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
  version "0.5.1234-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1234-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "91a176400154d13f6c319b14f477c6399dbe6fc73f69c42d12431cdd1491a3ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1234-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e3fcdeaef783ebff232b75922fa8b62e9d03df27302184a3a3ad4bdbf741b0c5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1234-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2ab5d0d26a5e44165bc71773d066f64437759a4d37f99c3aa1301023fb162ec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1234-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c503d2afb74854c76ddc2f65e03ec7aebdfc57e0195d3a06f373d400300d5ac"
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
