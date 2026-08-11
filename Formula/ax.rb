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
  version "0.5.737-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.737-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c53b166b89f9707655de775157f895b67fbb6a48256c3eb5b9b3a8541d79a30d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.737-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ee3d39b73ebbc902b9caf5e87243529d39e1c042a86360071a5ecf9c00858b9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.737-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "598f47944c9cbf5b5191ec0273476a683c7becc7637c02fd4568db7b8245e4b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.737-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "403eb58d06b85f763c713b0864ae4d95f1cbd9f5b6df7a1bce530deb409e6e08"
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
