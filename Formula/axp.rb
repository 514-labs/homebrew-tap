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
  version "0.5.1749-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1749-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9068503e0bd47562d9ef36042081aa8bd2bd276327e09a9d073f82fe19ebd015"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1749-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0cbea5e430e65269c840207b54a253fd3a989fb057b425bc2848587537300586"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1749-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eb60912ecff939f355ffca79b51a7fa9514a6667b4a38fae3c91fba8800a2fb6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1749-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "af7bd4eb74bc25823385c26d61a211f9bff0ef4f7f54150ac9a47c6b8e54cf1c"
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
