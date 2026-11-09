# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1695-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1695-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "70092b8a4ec52be95ba9cb42355a7ae2cbab2df33053dd80fd7684db6e5f0616"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1695-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "08a67567ac0d5a830a3e24415e64cb9b6d35f069653366a327cb2a374bd75c66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1695-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dbebac63d9c548708cdbfc994376ca4c3188e2df5eafbcb0b8d60fc9c35f0299"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1695-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97bd7c00503b38db2fcafda7687224c361622ec92a8701444675e5b0ed94478e"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
