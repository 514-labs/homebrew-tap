# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1708-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1708-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "27d528b92f7f690ca7b6cfada6aadab6a0b7ec87f1ed7f6348862172fe44ece2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1708-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "010c8cc5c630252f8ed67a993af6ee7440fd2971e44398b9a4cf38f709f2647d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1708-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6b8dc24fb48c539c3d6180b15b4e2ab6169c70b8d368a98d8b849485fbd8265a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1708-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bffcb43829435976ac4de36e3fe9534a4f464002efbd760de1b55f16de45cac0"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
