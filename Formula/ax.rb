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
  version "0.5.1525-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1525-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d6ef803f95da259498509d6bb1bb7e338a5dc5165b08464f96469fdb18f5b216"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1525-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6dcbd36e367f83239429d5e3957f5000b40df2d572c824bc808be37cd8f26d68"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1525-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5bd57963eb43b6b5285ae1ad678e024a470672aea32957b05a16cfa83516f9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1525-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2e54fcc8a6ea188388074748e2e5b24bb1d7e8856aa90b71a3907683547659e"
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
