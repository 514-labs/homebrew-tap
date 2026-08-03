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
  version "0.5.614-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.614-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ed276399fef8d766e56c3cbd5dcbf4f478652ed1e40d42524a82da8af7fed7fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.614-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "58a8017cb1bb600f6a2f3e900a4e8a6b9d63af0cbb56aafa558a8ad7f4259ace"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.614-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bbc28d2ee853eb33a3db60e7bf488aa07231b7e6c87849060fd66ebc16c16e89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.614-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "89dafe6fd90aaf767b1dabf82e2de3ddec8e0eae2a91ec76ce89632b58fbf76c"
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
