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
  version "0.5.1725-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1725-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6784e26d356432066576eb0203a0a7629c112303f05b6580dc3d72cc03407220"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1725-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ab955d273bd4ce32a72b34eed5603dc5f848eed0bd1f883e4d8c52f110dcb0ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1725-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5660c3328fbdb88d3aa5de01ccb45b8c7c2729516efe2c264ccac063b6fafadc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1725-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59aaa258e1b94955db5f72232650d7b6326f464c333d7ed7816edb492c1d7e63"
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
