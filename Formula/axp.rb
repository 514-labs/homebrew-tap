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
  version "0.5.561-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.561-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ddf51299e0cfdff8a48145fc10f4add5f5442fa6ae4ad54edbe1a103de184acc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.561-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c71f9a5700a6c4a24fe52d88725e47cb39cff3d2b6482b526099b7f985abaa82"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.561-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "52834c17ad25089dc95502ba8aa53b92ae66361049647ec3dbf596e43bb180f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.561-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b6980bf48e2b7b16e737d544b7c42051f417be8ffd2646d2447848d994575298"
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
