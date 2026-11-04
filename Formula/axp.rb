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
  version "0.5.1640-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1640-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8da5149aeed1413c84caabbc48baaca6ec7f3cc71df9fe679ca3fae13cbf5e75"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1640-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7bad0f94dfa37afeac71da7137a43a50ae99786845eb573288c8d5abde4daa38"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1640-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1c72ab90e7257728769868c91ea60c372541a4c18c231e1f3dec3e822a9ff17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1640-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5f3c28406b5921f4a9c8cb98fcb24e525d87abd0772a1893129827cdaf21759d"
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
