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
  version "0.5.864-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.864-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5ba4a3b7d91190e875634e84f891df5e5a66022d75f8a0119b6ddc94b89b8103"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.864-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fe3b9c2513c373e518581da167d69e3f564eee5838bc3b1e916e988b3eb0c16d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.864-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a37057f5007fb8ee4b60e2a5d83c7106cca9a4aff8f47829b67ab751f752da8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.864-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c5468ddda33098edfa72296d054edc5fbbb121c68a6de0cd0f27513ee768e61"
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
