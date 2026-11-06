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
  version "0.5.1673-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1673-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "55b65f5a6f9c5b1764579b5586404dd4d7c15147a5bfa2d1751fbd1d8d808fe5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1673-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "aa39cca7138af78a1c5aae43608ca862ce89fa44814507f2be068d5110a0a59c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1673-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec25f36b9146717e7c0c8909870105d30220d5a9d7b359cffb88938f77260336"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1673-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b39fcdfdf5fb09d6070e76bb7dd74dcc9754ece5bbb64ee5cd8dbe8dd0502d69"
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
