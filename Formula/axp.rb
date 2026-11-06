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
  version "0.5.1674-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1674-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ba6d40d8df585ca0caab7ce30f6528e532c24a5d10168d97e5fcbec3f20a7995"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1674-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "16e308d5fb67264e8b83d45eab132d76403b34c52b83d953ec2ed855b1f4f4a2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1674-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "276c4e85328ebd08e25995e73f2aa4f7cd19af8111a4ccf3ffd78ce569102afe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1674-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "166628da358c86ad9e3d564f693bae93c9d326a79d4589f2fc0f7e0a199ab90a"
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
