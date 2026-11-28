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
  version "0.5.1805-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1805-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "62984a7504fe7a3899f3bdf370c8f871fd08c6feb2e760c2241c52c640a06f64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1805-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c03482a063dca48a92230084d21c724c35abcbbaa240612cb61337f5dd9a88af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1805-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1dfc8d136bad6dbfe1abb96bfb0439f9578c8890543f8e2688e7fbb900cff0d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1805-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "952e78b636f7f5863eab2c07b476f4d321ffd642a25e1354e981f3488fcc60fb"
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
