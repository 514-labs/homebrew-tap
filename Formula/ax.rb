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
  version "0.5.1375-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1375-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9be3a3984c53934b06ca63b03bc75d5009797a2168836ca5aab462ce7cd50592"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1375-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "470f054d3413a39fd22979d88576d4dc9149f50825681ee40e8cb7c2489571c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1375-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3a94c4bd138eed1993a3f889cc25783c15d8bc308dfed073678f376adab62dfa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1375-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "666c013ba305c9aede2c57ba663b9b8b85d137e88303d50237d4db8096212c77"
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
