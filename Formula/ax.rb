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
  version "0.5.1264-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1264-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9eb3b9fca6ce6f9c08d2ff15383ff03f17579e41a0072d84d38f5767f13e1f98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1264-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d187c5adea46f17b66246fd238f18622a58635fb918a17908b3029a5f5936921"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1264-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "36f529ed0ee4e35d382a90dbebce5201ecc6945f8523ad3550a606bb9eb9cce0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1264-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bafb6999232497e7810ce005b9049fd2de7614090d14e985a1e22566f21ef92f"
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
