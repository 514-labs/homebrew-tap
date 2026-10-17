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
  version "0.5.1408-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1408-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b453a7ecb8cbeb82479e2b76c59843d992db851e04f873f274add367e722bdcb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1408-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a15908a09044c5d981279f9c53bf8eda645b8c57d225565c1b84018339291b59"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1408-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ae5f54e3f8a9292fc217f2affc66e0df41d0123614daa3fd8662215edbb707a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1408-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "430f08670ab50105838a5209849c10d624ccaa2320f31196315a5d6af6f02deb"
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
