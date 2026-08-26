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
  version "0.5.879-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.879-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cd1d12ad3c104d656a15ef9ad76f52bd80d0e2c9349db83cc9e2878177458c17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.879-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b43e679865f3a1fa844e53cfd6c05842615980b40b9d7031900de4cf6f9f8edf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.879-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "329f378ddae3d9b874c436ebe0cf2edbdbf7802a7a7f819403e43b88ae50b02f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.879-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f17e02591fa3081268ac4169e7d3d895c2ccf44949ed5f4e7d8473e35afc3c3"
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
