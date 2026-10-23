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
  version "0.5.1483-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1483-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4afffb742269f3e27f77e27e48345cf8fe66c098088efca74f9ac016101e5b6c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1483-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ffad4a10b3d5afd0556da076a787262448f8d50510353bc963cfe45c38f741a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1483-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2690b9b87227c2fee43ab00d170ec69485a6b62df1924f89caee34d56c5c1b7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1483-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1064138ea11531e8a2f88c8fbfaaf0e3a000d6a9dbfb763a088ef3c8f21dc375"
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
