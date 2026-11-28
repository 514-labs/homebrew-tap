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
  version "0.5.1802-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1802-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "070fea5e5d19581537976ae6ec91b88db51137af9d556ebf5980bc8dbd43317c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1802-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dee5e1c328824714f9beac6fe7d781b1832e0b9c33f4070c3fa460e91c8b0257"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1802-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db625de36612dcbbefeef39322dcb4d6be1abc6c466a9b383213af2217755521"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1802-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f08df79c2e1982f4ecbe851614f4861c65c5406a026fc4ff4c25b179c0693717"
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
