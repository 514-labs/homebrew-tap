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
  version "0.5.1438-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1438-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9da1be5d0e6112a1023e62f19fb033e34e2906ed1790124435b7289880541c8a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1438-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "394e941e029f5ab0e561aefccc6ce7a5709ec4964d3953096ca241ba38aaaa0c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1438-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f4427aedc1bfeb7577f3ad3886aabf02b95be4003d47ca524cb1b1b2b6dc742c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1438-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "60bf320e1bb8273913e9627273694c967954ff8ca6ee4ea21bf840c9f3dcf987"
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
