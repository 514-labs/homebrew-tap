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
  version "0.5.1258-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1258-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7b1c8e7cb2c9fe394ed6e34e145aa5d9f509ad356059febef28ab723e414dada"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1258-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a46a56ac6b6b809ec0e48a00d82dbeb54ab75ea3024991637974cd6e05bfe020"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1258-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8ba722e09a7d4a01a24e6c2ee2a02e9af6453b9b8959c5ae17899780449f35a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1258-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a77f601c450395a663ea2700597d57805235393242057717783921044cf8679c"
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
