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
  version "0.5.1198-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1198-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5175647b4940a5550e6df7a220d959f5fa045b64c720786cad815e7bb32ac45c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1198-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1f042f862b668c2f9d96000fbae80774543208e33c5a3c0983885865e73d33a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1198-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26ab4ca8a6d53f4189ae2a909e13f50bfe57fd57b9a07c096c926f5f3e6dec75"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1198-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "73adc8f412f7720325d0c6c6cd66d908709f6feebb7309cd6264779a575519b2"
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
