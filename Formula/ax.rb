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
  version "0.5.875-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.875-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dbfc41806a54e11136cb0ce380209608e06ef0dfdfda1a53e3d4b4062175c8bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.875-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d0c50a1e3c752363ca459b9d99cabb494d3abb39930bca7569cb5c958f3f29b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.875-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "868da0767e69a56cf985ac082bfc6e024b291d9fa19c11313f56bcedeb8faa6f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.875-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d02a337ca0d8b81ed26929c3711b0e60553743edeba230e3d336d7190c41aef5"
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
