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
  version "0.5.1652-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1652-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "473329ee4c3b1d933b8947d5e174b887a5e4ace902e6308f0a74dd42af0b1ae5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1652-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "551dd40112fef9a091ef9bf4eec8290386f10fab0d7cad63581a0f4ed009270c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1652-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "870a5f5a28b643c08f8e72684d9868c17116bb4484fbeaf46e777c1f19f0a8d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1652-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ad5713f00dded871d82182811499eaffd47232984595c3a58113f682f1c6eaf4"
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
