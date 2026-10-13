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
  version "0.5.1344-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1344-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "088c84d9d06217e5dee294dbc19e79b2a9f8bb8ebe90784f84f8558fceee959d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1344-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9fde6d9de01f6aaf76b6ba53b8d27e53e3866e64294b21498888236f37de2028"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1344-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29525b161cad65eb895f037eb62f56492f62918e09eddecbccb75bbdea908031"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1344-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "322eb7384ec2f656f5ea420a21078c34c3b6f6cd1d66ea96dda5bb13e6cf14eb"
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
