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
  version "0.5.1232-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1232-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "27d2e37fc43ffd6551cf5bfda7a8dfe3c94ccb6d76c631e98371691c85cea7f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1232-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6f45568c08469cccd8327b72efdcbd11d9d05b1a05419abd41036588a52225f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1232-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "471931934bfe342bf7b536d4943cbfc30a6b897890113f6ec6c60ba035353ff7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1232-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6f69cf11217dfea86b1d54652780fe37054e14300f29544931be273ca5df3c1e"
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
