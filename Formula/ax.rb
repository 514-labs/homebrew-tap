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
  version "0.5.1372-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1372-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dda64e928573b3c3ef1877936f1e1b406e898af45c0094fda8de370b6c3b2cb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1372-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "89c22bc519fcddfb9bb3d97e7f0622a8f0dee8a7156142a831a65720b19b207a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1372-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "64df0650574f29583bd35f5a29f0adfc6340fd33785c3876453f6a466241615a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1372-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b7a8a19e98c3be6e0ca4da64d4a9e70fc0f4d42e04aadbdf12695a79e709fcf4"
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
