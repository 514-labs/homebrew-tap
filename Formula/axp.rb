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
  version "0.5.1671-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1671-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0b8e3a9cf2d99a4c4b21802c89568d62a890a525b7b09349de4b9400882e3bd0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1671-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "395cf8dd9d61ec418d9dd364c3dd2bdf0ffbda485a20d7d21b9ba2abf0a8f475"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1671-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b2d6b9b99c0699b942ec82b1443320f903c8f40ae7ad3f3712cd0af36b34be67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1671-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b528449c3cc2a82e42bfe81ffc4d6005903a8c0e170faa2fba78dda56e432a71"
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
