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
  version "0.5.1268-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1268-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "da2a9638413909662c1fbea5f8680877bf54daa03ea2e9cda3c1d7c829e9f25f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1268-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "24b09c31e9ace401528bf62be6244ca9cd62b4a9570b5ca567c8074530711b1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1268-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eba59511c8d8434f7cd85ff47953de981d20351b7f7b9f06d86e1d321da1c3c5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1268-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef8ded7575f74a9b3ea00cb1280c4620c9e70dcd425f8fcd32dbee7b5fc4110c"
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
