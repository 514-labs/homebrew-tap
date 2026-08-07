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
  version "0.5.688-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.688-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1236ca2bdf445af8f1fee0bc5da436e2bb8e3bebb88c9978c59542c502a62386"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.688-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bbd168ff864fe568e6dcf79daf33e741a1884725a0b61406a5053e74dd8b2544"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.688-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3214b029357705e26c88da0e3bd208e02963def8a0033f49a99f10ede189ca9e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.688-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86b065db7d63500ea0f9acd0b243162d682538c17461f3de67317bf8e85b1701"
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
