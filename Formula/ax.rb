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
  version "0.5.1360-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1360-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4cda563d5f9d56d48a281fd617c3f5f7d54a163ce9395642e755f8458fefd7db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1360-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1147ad336cb44efc6727a83abb4e7d16bdfe5f77bd8f0d9abaaf779492241f28"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1360-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cc17ea9e32bd8ea4444f8fcba693dace950147778e7a7638df854b6928706ae6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1360-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58201acab387ff58da2eb984789d0441dd7079cadf44280c482b07115f7e033f"
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
