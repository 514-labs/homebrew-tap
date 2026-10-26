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
  version "0.5.1496-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1496-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6a4bcefcf0c188dba364ac6c5779ddb9985be4fd1c7fe7bd2fd9008578885d56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1496-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "06395d2994c6ab7349306f86c4f36db64b88806668d4e0a2b29b215a95e83564"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1496-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "28ceb46881ba1cd387cf3678bb59682978b3b79fe155d95827326b836ae24c8a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1496-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b6183292a78342d9833b14b838ef233f29c79529aa77c49669837f2b46d7c3a1"
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
