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
  version "0.5.1747-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1747-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0eef89ef2024f569749dec4a1bbece3de2e6bf8a9dba50b3800112a4763ef6a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1747-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8be3054205458077a0232fb4ea12eb51de7a247ee7fbb1d3f7ec4166010ab039"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1747-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "74055ba84b05a28101dea4a944fb3af89fe5fe8093088b5e24caf2efeca7e7a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1747-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ee12898c302d8103d5d33847949fcb23032e24b031fe66c27e20997e8b0d9593"
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
