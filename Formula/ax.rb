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
  version "0.5.1164-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1164-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4f985716583df78760ce480fc1eb36236eae56d3e3286c79c07c91d312a34482"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1164-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e5eaab5e3d01d0913be158641ab43ff4e8711ec8ad01bba635d2ddb8a2bce761"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1164-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "343b3dbe12c8cddda73e5d238080e6b510aa322ffc954a2971787d1fa56aa7a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1164-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "531b54afddbc0b1a87065be967474c8bb5eb2ab1b3076e09495fae165fbc2af5"
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
