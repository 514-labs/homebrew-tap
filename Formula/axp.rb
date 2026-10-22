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
  version "0.5.1465-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1465-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4864ec5589a2dbf1f52cd7d1931c5ceb027807aa937ea4b3a4c1d97987076a98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1465-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9fd844ae82bc2aee01c4ff232a895e59df671456eebb4476fc9c29eca44a3ced"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1465-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b10f255fb656ee0b88b50548ac97c3db972b49052273ac0e7554be3b758f186c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1465-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "380c1228ca65198a8645739b4940be4344986bd457d175055c139dcef64e24df"
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
