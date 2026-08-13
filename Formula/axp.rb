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
  version "0.5.756-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.756-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4711c98aec49e5001c82ad7fabdc0d276c61bd3ca713815fd15ee62a895d18e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.756-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "082673bfc8d696881f2d9a74321accc9a3a555e8220336e06a840e038f65e119"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.756-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0c41409503af6c3098197ee590b763bea36fb819f3454fb03172cd5b6fb7fcaf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.756-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5b8161402cd32114ee5c3c0fcf50dba9d78555492f06fbbfa391db0084eeb95b"
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
