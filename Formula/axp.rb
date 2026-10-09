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
  version "0.5.1297-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1297-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "36e77fc884737180048b7c48c6563816533aad66a16efa61f0177f6d58714dae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1297-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dc0eee96bc0749919137e5a31c72dd24a94456f41f0b9f3c97cf8bd4327fb112"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1297-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "004e9749eacfe52268d6440197033e30e7e17229708ce4bad40a43dc5526ad70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1297-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b6a1616b004cf8770eb471e01a5fec5c6ab6bfa15cf23ba332d224188d47f5e7"
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
