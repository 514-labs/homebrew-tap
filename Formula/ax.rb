# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.715-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.715-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c17252e8c007ebafbc64929fd5011cfd6d1ed06711f72ecf60e6373cd69a8acf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.715-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c33aea247576d473814948c48ca3bacacd5b603a54eb7c5cb89673e3e0cb2059"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.715-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a344078ab5459855cea5856d275acbde2a09cd7e69d7a2dd6a6c0341049430a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.715-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e1978c920f8e182dcd90d95d6a83d25a62e00ffb9fde4e6b5396f35da6aaa0b6"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
