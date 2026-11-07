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
  version "0.5.1676-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1676-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "41f18f3980a79a5c3292c7ea92955421f38212bf6d467e4c07add7ee0eb6681b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1676-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f3e4a6332fd46529f6a1b61d44bfb330c1b7c0b54ecdd2e6b1cf9ab4f8bef686"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1676-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "442921ec7a866ed69eb0a05eee7017927d0a7ab51ced908f1a892cb94a3b8a5f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1676-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1bffd15b611c78bb524cb9b68ce846ecd1a139c030014f146d0fe74062ec42e3"
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
