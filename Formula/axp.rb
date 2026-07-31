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
  version "0.5.572-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.572-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6bc3934a064561340e45c64ad438ad740b88a66cfd385d2848ee2e230e4ca47d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.572-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3588adfb467df4a4729ae3e0cd821a41a12b3d92decca03d145526fb5f44cd9d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.572-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3b2e85dee6042f6df56c2180b89530dcf8c528f321f812da26225479f12de1d1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.572-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cb546c038ad59114cc37700bfe15bdf659b3dabdbfe7ca64eb3acc3fe99c3bb5"
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
