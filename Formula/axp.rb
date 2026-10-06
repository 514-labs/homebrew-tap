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
  version "0.5.1260-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1260-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "43871adfbcd5fad91a5a6020b0307dfc06d308daaf4a723dd845c8b45f11fa90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1260-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c4f3fb17d7b31c6bfeff85553ae0c3772c2aca76deeec4c685dd6621aa9e3f65"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1260-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3865d6119fa29cf19750a80bba782211c0d20672c41905d3d5865e1b2d1c44b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1260-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4dde94ba0506364961f656a1dd53b0cb5277804c71df631c78dfad773a3b816b"
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
