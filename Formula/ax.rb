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
  version "0.5.1386-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1386-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "08133bc4db3f85009ec76f38c3743e6ada28a36b7f084a8fdf00bcdf0f0d3bed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1386-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a293820aee2e84c4a51f468c58b7a6876f658aea58ed8d64c0ef24a8ddb55388"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1386-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd4d2174315d29be294454f1a7244dcb556e5c148e98d8aaf45e8f4e8f748d47"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1386-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ead3bd3782271134911d316c0642b31a25844033c5127b6f25c4e8cae225d10a"
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
