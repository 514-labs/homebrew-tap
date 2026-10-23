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
  version "0.5.1482-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1482-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4fc46a6071934a38b85889d5e35645215e22da278f0477027cefce14f8fab91a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1482-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4b75fac41359f4296544ece7d426fb436984db13bd353f5cd4296502572e9e66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1482-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eb0b2fe5c167286c6d99909ce779706f6ea8180580108fb9756999bc574f869e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1482-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "efc94d6eb8618020861d1b77174e89392176b17684a185ed334640d744afb5f2"
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
