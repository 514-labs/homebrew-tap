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
  version "0.5.1507-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1507-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dd7e61cc904386c0987e5dd68f108349d14a8bebc9a921edf5b355573f95df7e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1507-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "189b8279eb646925e4da862a8d8dcbd1f87f5df1e546795f1d8f8ed2e96e4f31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1507-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b520d9edfa9a33792e020e0930d3cc718f4a57b5acc078c1f7402bd00589345"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1507-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0fe8d336caba9a139e9c38ae3d276a4bb1a8251cc60d61ced5cde297a5efd76c"
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
