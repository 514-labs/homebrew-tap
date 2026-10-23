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
  version "0.5.1477-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1477-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "00b0f6671cef149f2d16b3c643dfe0e4702f8f064744527d123897e5488efcdb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1477-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7b03aa42c15c4fc6b6c001e64af86f50070179e0edf96473c50dd50bc17dfa95"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1477-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b94a21b633eedfa05953e1064ddc7012c56e701f07bcc40ac42092207c0ca6f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1477-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "95c8e44c5920ceeba4ad661836a01391bd6b8e31cb28b5cb07016d5653df461b"
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
