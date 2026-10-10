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
  version "0.5.1317-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1317-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a97fb734f1d3165a28fe62ec4e58efc94ba3c2fef51d6b72cb27bd7a5b73a375"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1317-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5816e813df7af20d2d15fd2aae380d9bad90065456a359c0697ad1820545bbda"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1317-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "78952215ef3df99e362de99b6038d3d448aeaa2b0db39addd9aae9e808c0d3d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1317-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b83ffa7581a1e1fbc6a8b71460b749f5a8c68bc2afe530537ff3b42ba5c53a3a"
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
