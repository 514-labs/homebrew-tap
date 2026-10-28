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
  version "0.5.1532-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1532-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b2a326868ed7634ecc1927c79850b3fea8fee3a975c0cd2979e50531d719e803"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1532-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5018b986154ffdc02f0f8459a51ecdae926d1ae81db4c8df7c105811106ccaf9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1532-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6bfc1f86ff6c2831d314893b0614838873d69df191b29bf3c37bed34edc5e138"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1532-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3d677cd380005e62adceae06ce0515b15eb3cdfaaf9be529a893b2066fe90efe"
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
