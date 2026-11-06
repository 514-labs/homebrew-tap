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
  version "0.5.1667-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1667-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3fd50ddd4f03355ae9924b71a87da28bdb6c8d80ef29ad3cdedf8b57fdcb4931"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1667-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c052298cbb30ede501988a88eed3b3cda6c3a34c5261f71889291647f8c8a01b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1667-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6aeccbe1ec72bba9214dd57f2f33851c09a526c7d2e240a98a6c00443963bdbc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1667-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "857ea6d2d9de431601bc49d544790df068a52234e14de91beb03ef5bc7c7445a"
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
