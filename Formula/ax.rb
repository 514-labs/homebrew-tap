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
  version "0.5.1021-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1021-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3297e9c743b628d723e74e1d93b37302aec1c25edb8978ced806acf53bf8ea21"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1021-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dd77523f26fa02c1f890e11a14689c7e0f41696b43848c7997c1bd8f49b1efb8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1021-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59e7ed5accc2c1149875204b1fc81524edb5f0e556d1322937db57557ec8ecbc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1021-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26dc125def0a70f53c129061920367b9e86927942f843943f218e1c303d50b6e"
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
