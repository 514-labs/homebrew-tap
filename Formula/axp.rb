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
  version "0.5.1608-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1608-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6a9e84080733bf923121f38edcacd9bbf33916c58151724761d726cb8376e931"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1608-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "17687220d7997a18762024027e933487f5702a4569e6fb885f1ff25dc076a19f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1608-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9d48fc35509c21abb039d6d3644fdda1da7ef99bbba397a4e6af0149ce4ca2cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1608-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7ec3d14bfe2ae306ad6de9e4267fc1d9682bb0745ffcb749372ef52723fc4eae"
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
