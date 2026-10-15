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
  version "0.5.1359-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1359-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3bfad7601954cb1bad76b424167c69d796a83d46f78ef932788e5b30c2eeaba9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1359-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "98d90678bffb7e0782a38740243b54f14bcdecc9231d70e16784cb15d2b38c8f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1359-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "95e5b88dd2ef635844708572b21e4dc15060c9b56daf1a9d963b669502d293f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1359-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cb9641b10f1aaf45589ecebc242aa8f55fe3ba6535a5b910c3613fb267d6a979"
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
