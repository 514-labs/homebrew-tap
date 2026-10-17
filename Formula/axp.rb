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
  version "0.5.1409-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1409-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f9eb322f214d7dc070b49029e7d4b94ae188d1d809b5fb67f07c6347f2313c9d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1409-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ccaf6c9bc050c3b1ae4415591d96d5fc696226f4391afd19d4ebe5a9272d7299"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1409-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ec78012472d955a503a54715069974966a33dadd10639f0b06787fddfad01381"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1409-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eb711d297eec074c214629c647c5e0f8b7769254a34f2d033efed7b1adcc73d9"
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
