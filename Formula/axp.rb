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
  version "0.5.1371-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1371-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b5aaa20de82eed287ab96e037a37d2852c1ee182e1b10300ef1b0abd8d2813b8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1371-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "79390a5a8abab7c45caf5e0cba9d38dc2b7e2753538da096acf9c1cc030765c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1371-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "31a00a7919e90006ccf23eff5cd1baeff4901553c8b3547e48c33b8c93cc0106"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1371-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5bd6f1957d5bcedaa0d7b48a39edfa7ff08a2fe1fc4b7dfab1159eacbc1e63d5"
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
