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
  version "0.5.1288-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1288-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "65445329b279e12d137ced94fb5b6bbcc36602a4a4f0357e77eec2e3d0b5e1de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1288-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9c83d553fa96c7ac3549740b0109f3177303dc8c5a5e429fc7cad26531228f60"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1288-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a7e0b0f1cf85e58b0a6b358218c78bcfdb3c2e4e6a59fb82372797b8e022fccd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1288-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "20fde17550aaf53945b36c99511923a823ca9342a92bd98ab82075eb3cba0911"
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
