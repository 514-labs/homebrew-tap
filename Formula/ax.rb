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
  version "0.5.941-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.941-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "36cb48902e4f6a993802b40e8203a1ffd1ad241bacc87b4ac5d46df67e3a3f64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.941-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b3888b4570c3161fd3483a92e100687bb49c70bab6331ea6dd619fefd44de12e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.941-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d7ece2df4561418c01bd2ab95e6426ae9eb62b65505086f88895263a753ff37e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.941-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2fcaa6687f36511b655a0a1a5c8f565219ca3aa8f25cd283bfd041e2305146f1"
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
