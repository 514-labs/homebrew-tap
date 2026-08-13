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
  version "0.5.751-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.751-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8bfc847128b8370802870eebcbc210c8d19911e0ca027f4dab10f379abf5ab30"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.751-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f1a2ec46e70588512b23b6cd754c8bc860cc1306c055ed9a0ce34fab260fdc02"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.751-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f7737fd26288d08ab9f34aef4efdee88a59fa371bb5a3c1c17a0c712d0ad9e63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.751-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c01c09ea913e230f09599efbda3048161a3e24306b6c1b965fa2bf7bf668b24e"
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
