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
  version "0.5.1347-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1347-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "13e5fb4e57d6e48e15ac41b07ac36828f69870eae541665bc746b4fce20605c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1347-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "63a77a145442b287482b7c4e19a06da67f6cbd66bf8352605f053015e1c78548"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1347-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1e650961b7b0622f19396d82515a8be7350daca58c3d18ac8a00681099385558"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1347-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d570b5e1ddcadcc726a878bb0983100386693a538f4f60b31a43d525047da91"
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
