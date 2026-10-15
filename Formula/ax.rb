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
  version "0.5.1361-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1361-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71c381d348381d4d6fe26c17ef60fa56cda52e3ecb1a3641ee91d36fffaf2378"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1361-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "96938b32ddc208efec7243f40400423a61d0a87ac6adfdfe73def8e9d112d143"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1361-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "79554562c55f80185f1f4cd694d3760425308355c2213247e5d53c63a01ddbc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1361-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "17c6e7bda944a250f07de159ff15ad8a5e7086b373782d43acf8faf418999dae"
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
