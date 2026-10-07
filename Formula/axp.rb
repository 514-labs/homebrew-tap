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
  version "0.5.1268-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1268-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9423bee4ffc74e66b4d67d08d1a523780b66e2475c7c41ba86b409032c536322"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1268-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c6feea5c375b02d00117171d9d352d4cebdca4dacace6af7c0d8cb64c29ec969"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1268-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "37b922e68a762a6d91d51d117acbd05d96b0c22b338aea8ad8e47e5aa061509f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1268-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "47fd8ea8e28832605e0645ce163ba21c113b13df8688e219830cd0f456109bdb"
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
