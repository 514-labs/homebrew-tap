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
  version "0.5.1739-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1739-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "733c5510a9a1163d6bcc696eb778523436044692b8d39f28a1dc50c8223af7ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1739-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "60b3ff63a6060ab0e824fe18025853201692e9c1f9ba76a454c6eb65bb1d9f70"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1739-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2d0dc2238dbb5a1dad34e98af5199807100c23c55380436f5e4131baaf738ca8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1739-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6381c23b750eeea16a2cb945f69847f536b44f9f5d79f6bd121557f7dee1fd68"
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
