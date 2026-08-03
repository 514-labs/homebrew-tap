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
  version "0.5.618-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.618-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "538bf72633f36196f2844836339c019e786de2b4c51d579fa8cc63a608d0bc48"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.618-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0745a13e6ac1dc47964611d222764957f483183f696bac1fafee05db913e7323"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.618-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "556746ddd3ede6d78eb2f27b81318207346111f70ac061a89c342677f4bd5737"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.618-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b8dff2484c45ed11ae3b89267db86a9ed166718e6da90d224c55b4aa8dbd8534"
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
