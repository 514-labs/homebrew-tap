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
  version "0.5.1656-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1656-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48a32c629d84b3776bc61875f2159651bfb6994b51395d8c5b8e9601a563b9f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1656-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9c51cbbf90f29964a9a73b4ea1775c7caf5b7a897d522930f1a236f788f03b62"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1656-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4a4abe72bc83822dcc632b4c446808fab86ebd8e67456c60170077cd3fd7b6e2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1656-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5b696c646eec1b817e2ee4446356de999f00086604ae793c667faef6204dbe1e"
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
