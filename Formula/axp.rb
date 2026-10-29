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
  version "0.5.1539-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1539-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "db93b96b0f15195c0035ac81b671b99504bac04eb69efd15f03b7c82e9e26d2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1539-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e45736b0fa4124a35a8548c772e1f8f9f1ea32655f12374cd3a70dbf87714386"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1539-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "15419eca4c7673ac345b5cc3d21083688c147f13b6da9a563d1d9ecec01f99a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1539-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a31da7166e6b61cbff22377019481c1c63f368ccd9a011354ea58ce3f400064e"
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
