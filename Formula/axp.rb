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
  version "0.5.615-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.615-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8550257e08114dcd911fc221d5d75b6a7a3ae1da9efc046e303428eda3a1bda5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.615-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "edfc142185253611a806294fd4e418a1774b341d8fd6af4d56897b9477ae911d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.615-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b4c0ca70f5ab38500c348b5382bb9a631495982020abba668707d722ac6a18ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.615-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ea6636fd925cb82b80fef3f0a75bf70fdd97b60087b7776de0b805cf3ff5860b"
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
