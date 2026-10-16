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
  version "0.5.1381-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1381-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1c5be068d156a5d23f91973d094f3505cf350d802733cde338ee5b375863261e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1381-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "94c33fb51975d3169c515ae3b41f5e64a643454a362b34a04fc6ad1868aeec12"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1381-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "23554c3a2372b59905d45de0ac777b423be5216ab13837c99ed080baecdace32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1381-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "89bf15f0aef85d335bf61af452cb11decf91c9f98c5098966f4a949093472e64"
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
