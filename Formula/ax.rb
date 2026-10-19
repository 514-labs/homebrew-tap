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
  version "0.5.1415-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1415-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "75f61e62a81ef3eaddaee73f040266e8e5f7074dad8757684a0ca0a2726cb32c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1415-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7ace31a57cfca7d3f7f53276bc7a2b04fd1b789a9d41c4b872aeae028f80a9ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1415-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84ac4a9c24be23a77dcc9407548e4589bdd56e97bbb64f3ed13d999a62dc6b53"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1415-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "48c12f9e7ff9b11826e2c0e1f5f2f54127e2a1c9a2c72a0d8275c5b762afdf34"
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
