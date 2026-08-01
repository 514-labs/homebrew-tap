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
  version "0.5.578-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.578-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fa6ebec26129350b7afdbfbcf318d9c747f41eaf46995e59031249a8a749c241"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.578-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "756e5da49734dc494f6c46fadb95ab9ae68c92d09a0d0c1a91eb7df20db969a9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.578-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0ef10f0b85f365af11639051627ef23d4deaa2a082b643fec81435d043eeaa28"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.578-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0e141ded6204541553511f2b3a803f1fb04066d15e39fb16e6adafae28f895f4"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
