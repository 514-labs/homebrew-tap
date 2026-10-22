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
  version "0.5.1464-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1464-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e3cee7c020395db0e91b93108f791abc0e362ab926b5065dc25a8c744d14b0e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1464-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bac5df2a55ccf96007727fe58082af1bad6db367726e9fd30c7606497d37f998"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1464-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "01e39be0735c22e7e5d72c4dbe3aef5124e464774e779de5e5739036a3aefd0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1464-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c471cf3644f66a4018a679fb267a259e9b5a019ccb32789eaf652640333554c7"
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
