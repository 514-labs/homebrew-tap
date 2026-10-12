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
  version "0.5.1325-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1325-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d5a81c73f2cc21f52b74515d0e76b3cdafe70979ff6d71fdca179fa969045cde"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1325-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bc7dd7fa65a08182e3ba366e8d7c2f56fbe5825cf8f7fe53e1b8d14590ec695b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1325-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "934fb3514d63d423f127d16b9a75e2454f7e78aef7369743723e78afcb70a860"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1325-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2cf5b127c20ca6f74a7aaf0887392c774304b8562964266642873d232e1fadb"
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
