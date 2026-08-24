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
  version "0.5.859-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.859-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b21cbd64019f323b7ca0246fb87d15f44f29b5315ae5cf12585719b4f4a2fb41"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.859-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2d2e208f764f26af31e5b055834dbe7427a713ca94e20b01d7550bcadeb6d060"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.859-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aea0eb199b9cbadc1c2490f90c3140e9af0a878593c05487da01a235e2cd16aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.859-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0e62357b065203becaddaab8960dbcc7c1e9a6f477de6f985f46cf4471316053"
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
