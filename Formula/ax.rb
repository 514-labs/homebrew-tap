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
  version "0.5.979-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.979-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a180473b6fd162df4c027add7fbddf4535769f7a1a4962137993b7635a76e229"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.979-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "56d16f8647e317e90b4f41a1fd196bac91fc49b7e8ffa1d54c573d43776370b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.979-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f46883dd8c5365c2448a7ef9bc7fea81e992637efe61a1f31c06752f3562db7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.979-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f6d43cff2f3959560c69e74c3243b6dfa4cc64fa451fd9e52b87c6fad6f86ff8"
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
