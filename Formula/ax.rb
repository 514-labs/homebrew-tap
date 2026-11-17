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
  version "0.5.1736-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1736-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "74b5ad2ac52da04a48299a6734a80eeefc9e6364e77f4e3656dcbf8acc9b1f2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1736-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1c039b7630952ee07fc01b86483ed7a08e7b12a592ff79ad7bb7ff1cadf72c37"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1736-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2e7368498789c19cc771a8603025bbe91d69b4cbd4a032a92ed7da91ced01ec4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1736-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8156c7cbd16daf258cb1a57489d518dcf2d061484992f445f7e83503e00b907"
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
