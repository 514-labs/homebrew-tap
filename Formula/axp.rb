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
  version "0.5.1258-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1258-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1ce56b90cf3d810dc3f54e9e01b4b515956ae57f67ac680cc4e76af2f5599d42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1258-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4ef26fde7276f7779f3ca319c2c6f29a322bbf826fbb422b229c3cbdd5dfd6ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1258-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "432342d4da281ae9e7ce95f79bf612d712f8e47523de4cbfd130d44e6941ed8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1258-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d2161d64f5c444a4ff30429efd1dfddbd63059a331dd3d84a63900c0497a9245"
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
