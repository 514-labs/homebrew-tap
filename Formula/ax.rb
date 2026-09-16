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
  version "0.5.1053-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1053-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cac0c57f23be7d6ae7d8e269ce9e5926fff052db5b6a22ab851b477c7553e0de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1053-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "843a83fa35f38d72db77e494386bf89a4e9149e4017b7f29cee770fdf1303be8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1053-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "62d903cfbc9f167db8742441c11f6425cddb07fc5d88d39c44d063d72e005cf9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1053-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8f1eff56a03bcf92e8a6ec7e295ee1e5c579e9736f3d5c45410ea92d6df6ce1d"
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
