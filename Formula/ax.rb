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
  version "0.5.648-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.648-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8cae5ee77be7c8d90281c9f4588269980966c99029a9563c679077b00b8a5c86"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.648-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "74554b72e03c6cd0d61e226eb786224b8c0f199d30ed5b7dcaa800bc70af39b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.648-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d3410d17ecf2b9790bbd5de23a1d19b3c3e13fae1fdc898994d760cf4be03e9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.648-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "927f57c6e30ee6394349bd8359e4a10490f9b093665f67b789ef474a4bb3b1d6"
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
