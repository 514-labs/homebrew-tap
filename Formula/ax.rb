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
  version "0.5.1803-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1803-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7b30589d28c992a3436b6cf7d0c45fe303533c2026da5d74f4c56ba4eebf4fae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1803-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "73bba87ffe84ed4c6d69b44e86f72b166353d0128203486d23b8b472e94c6488"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1803-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ed1d244032b1e4702f61a8f09a6f9c51f66af5ffdadf0c6893917b11ba054e06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1803-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f2ee7fac146a69ee95fa28ddfcc73151b857698218037fc61d7470ec41afd87a"
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
