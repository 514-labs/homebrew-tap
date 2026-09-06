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
  version "0.5.963-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.963-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e127e8fda592fe8d9478c563de3ff4354e01601f330fbaedd1ba5ad2a6a35332"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.963-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "28a67dc6659169d7558b9ef580e2cbe10eba456bb1e9a27b9273370499ab5021"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.963-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4d6a18e5cfce9c291c7fe2747aba4e670b21180983ca83e5d36a2cbaf4200860"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.963-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c1fc9be8a79b4905fd9fad3a45e27183412516cb76b3f0148f83c91562555964"
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
