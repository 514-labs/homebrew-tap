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
  version "0.5.1138-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1138-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dbacd2c9e5d2168ff2a646e0791a432dca198095e0fa62f5e072204aa6b9b651"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1138-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1688befb758b368d384738a7a8b5cb3afbfc4d329ae31285606606523ee3bf7d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1138-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "293548fa19a23265161db8c32d6ed9772edbc0a3193c255fa1dba43e3039a2fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1138-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7556b7d0f5aac77158667249e1effc94360571a802fdbf4d5799d88efa99d05a"
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
