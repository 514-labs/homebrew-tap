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
  version "0.5.1274-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1274-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a067b9947f59f6ade74e7f29dcdda38d78845740c4e88e8ae3ced9886a398b1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1274-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cd89329eed3415823c1e4f16997a36181859703341106ebfa138ae2a452f0360"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1274-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "771867d7a21c6b8c8534456e06c92d22e311ff08def466f2d43a498f739709c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1274-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7fa3d68a1eabe4d9cd2b4d7a1f21db4e1a618ff2dcddc042d98761f19adfd881"
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
