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
  version "0.5.1279-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1279-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "25ba6c67237fd2ca7656b105c73336e59ed2d1980e0cf4132eff34b7328cb5ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1279-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0435362db0d869b4f8e2b67fe5004d43f4d536575ed4c09908b88d253310a136"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1279-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "25af02a159179804d81273bb0487f00cb23373417d4497218864e9ded38b2d62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1279-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f7b2787990043a2f9639a707efa674f1c923fb4c53c7eaf283b16906d6f21aeb"
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
