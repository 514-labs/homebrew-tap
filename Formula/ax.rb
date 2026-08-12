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
  version "0.5.744-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.744-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3b448c7530c842c7f4498aeb2edc54d8190f6260938eacac4acf508ba9b22725"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.744-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "96260fc5d4b4caec04c58860f478d2a1e504449e90d72d25a0afd7b229e0eca5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.744-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7cf185287726369c1becf60410b51621a828b3b0f0cd90b88249284ad1d02488"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.744-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a7ea5958c8ee6621c7f137af3b00473b19fbae043b3660503b89a8323906d0d4"
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
