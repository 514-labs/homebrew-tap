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
  version "0.5.1196-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1196-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d7e002d25a04537a7b3e0f308a3c659143a4938f73b333ff7a88a65e17f5e87b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1196-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ef2a6d284d48574c3a74ecbe152791fec7cd4f9927cc5ca8f20f48bcd8f71446"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1196-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "180f40efdb4a4b9c8fc4a2bd40b9335db104306388c620fb0e4fb0245b828b63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1196-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "48ee9da6f9a146c7c292a2a90ad82f639c5fcf0342742abac5134c53c74fc518"
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
