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
  version "0.5.1731-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1731-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3bb77bdf71434177d425df4354d850abc0044bd036c3e107ceba1e3049c11522"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1731-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "85936cbf0c8951102293ddfc50afefdc11be403bc60904c03fd32d226c4e9d44"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1731-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e7caa5ad06cbe1d6539f32353f0c906831d2e1399071304b76cd9861493cbe52"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1731-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5f0cc4cc828ab9d225528096ef7e5334d32736882ea0c9fb1c3a44ab4137969"
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
