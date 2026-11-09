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
  version "0.5.1690-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1690-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "417222fed0ac33bff5f13a5b17c71a5fee32d36324953161ff7c323c38bff9e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1690-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4246f217e64a49796e26c9804f50dac080e870bf3bdb239b4552e997b909160b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1690-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc5ff6558e9161b4e4753fed89383cbd4d28bc4f36a1ce72445a18bbe2d409c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1690-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d83c8980598aebce0f8cec806e7e87de5cf5ce10d5c81c17568e016ec0729d9c"
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
