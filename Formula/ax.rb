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
  version "0.5.937-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.937-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "46111cd7a94bd14a88b82dc34d68a8b7a9ebefea22bfbd512776a978bac853a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.937-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f515413960743476a2a6c10b276fd8064f1d33e75ba20e53af2ffd828eb37f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.937-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2f2dc8aca18416d0696241545dbc5b3e9f9d3d04ab021ff1f05770e5a7d657a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.937-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6f41a10b0f87d0331f27fda913d82005e8b0e3711b648d3a35531f0d3e92c27"
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
