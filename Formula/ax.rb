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
  version "0.5.1646-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1646-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ab6f5289e0da18671ebdabf1103f8dbddf007b95f6b4ef75b6de7159f4fdb796"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1646-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f1540ab4a3d4c2cc25ceb0c1b3296331088ca024fa4f61b844aab96e93e3e99b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1646-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d513846e48da79938bd6ec717c6ab3870ed296bcc51bc7b1a19fc13ab82a1488"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1646-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "829d2bcbf5e800d93bc44e04493c4d692fb251f5c9617ce9af1be20669a646a4"
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
