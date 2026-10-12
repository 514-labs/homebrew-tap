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
  version "0.5.1333-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1333-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9e55aed42de3180be9aa60429b69076ad293cb84f394b209854496be363f8126"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1333-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "95968539dce6a6a04ecf5a20733f0bf99bfb34bb82b3c76b87616173d555ea50"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1333-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ff846b70c546d2688c1c1e1be3374757147c79217aa0785c5c342534c199dc10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1333-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b40fad117f75da9dccb93cfabfab10281a82fbbbf342056ff47e0b3f71fbd814"
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
