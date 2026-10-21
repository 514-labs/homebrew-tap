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
  version "0.5.1445-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1445-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e48262edeec693679a4347f8094aa93c039800ff35ff69ac64bdf6fa3119d8d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1445-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "93533b647358799e030ee5452e155bf8b8de16381688ce2ac0e7a49c312dc0c9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1445-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "27e3bb2420f994c1d7c9cf55d7cb93d4360737b8693cfae181f4c12eb15a6784"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1445-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1e78876ffe1d2d9eb7529c6559917dc6b8ca4b8b3f58f53defaa03a34327d020"
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
