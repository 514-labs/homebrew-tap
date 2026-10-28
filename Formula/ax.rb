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
  version "0.5.1529-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1529-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3519de05cda58db4e437c0634fbe8a99b874a6f0eb951b7ccd4e2e7987268a0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1529-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4db34375bf24aec766d69290938088b59329fc7e1432135353e264944ce62b64"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1529-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "75fe2b6c83cc0aca53e5c4ca3d5409c33737513c1605e1a6ef3df6c28ed063a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1529-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7a6b931853012c3d9c6f5c1852613bb492a2333794dde466a4c548510e679198"
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
