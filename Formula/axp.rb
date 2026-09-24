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
  version "0.5.1110-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1110-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "db1879edee57524c119c0934e1574686851fe72e5ea2ff439c22916e65fe7c85"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1110-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "948affbc149239337ab128262c1c4008354fbb3f1391e50c382d3d9d967df1a9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1110-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48d926ac2ef97430cb7c8003bd4458bfdba0368cdd94ae29d2fe728ab91064b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1110-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e786fbf0798dad8509428f1b69b19d933ceea2e116676422241854df2954edef"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
