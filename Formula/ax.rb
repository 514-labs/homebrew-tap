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
  version "0.5.1378-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1378-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b0676778530b0ba7f01f3c27c0b946a27577accb1e320b0df2e881c16ec5b37e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1378-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "859b2bc8b21ac97a8359ad774ce66d49313de0d95310b5d3e2f305ef33231cd7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1378-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6684df01d0d3ac76250c8d0b5888a8460e62f6052bf144faf4e09b06b5648a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1378-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8915246bfbad0d7d11af4fa475bcb540ebf00a2cbf299e50e61802d3baaea06c"
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
