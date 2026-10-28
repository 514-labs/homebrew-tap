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
  version "0.5.1531-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1531-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e83109338d34f584b943972063d6639b0ebfdce51dff6d8e50dcc055d426481d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1531-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "502a22d3364c2e9071a7f4a3528877028615bd99bcbeafae3ec00e645f0a803c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1531-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6c3e0ac55cdacec0a0b8c762a87b832ca795570762bd2c5bc6cba116c18b247a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1531-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "334b4bd53b0dba03ad870e6dd9f75e233e521c73b63993bccfa50fda9577da16"
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
