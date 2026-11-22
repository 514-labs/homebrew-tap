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
  version "0.5.1784-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1784-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "47e9fc4940f5fd5a8cf3189ee48eca9e66cd5e75163e0220657dfa22473ca8e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1784-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "92e7d0775e4f7e47db87638cf6b12575015ceeb8fd740bce1614cb7f5954af61"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1784-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0fe205b2911202b23cbdd382711b66bfc8ed5fea0f879f320278f1b2b85f72e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1784-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0fd79a512c06491f80f94733abde1514472aaad406cc5f96c17b4dd7e79c608"
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
