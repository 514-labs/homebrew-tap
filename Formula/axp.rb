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
  version "0.5.1378-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1378-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "31ee8416b7f04a84e0df9996757081b964e37e9ac4afd325d65cdd9243513ed1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1378-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "312b3844f813248f10d2f72224bf29151aed00aefbff99e01e28de96849001a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1378-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1ffeea48494a225a753e8d19620c8924ed446cba608e85851277ff9e4f179c0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1378-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7ba8bf57eb4e2a68ce3cf92d2e8207e7cb156282c35d2b185ee4bb5bdaa50901"
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
