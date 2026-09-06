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
  version "0.5.965-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.965-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3200da1e6ad84dfcf28ad962c5db4e63f994efaa9816f4117ee208582c0a9979"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.965-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "03e58fd71563bf44d427596c244b07a843c0eed5a41018332fe9f57e17ccbafc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.965-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9494e64a97c7d6f1b013da4ac60124d9ba77f6793ae5c43d6036576d784f09b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.965-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b4400e200c4c31b4f876a86c9bd555185cf9e644b374247f2d0a891f2adf98b4"
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
