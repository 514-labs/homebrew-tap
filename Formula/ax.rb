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
  version "0.5.624-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.624-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1502731fc66f200cdab1d06aba5e990ebd634384fb4526b475cf3f8c2f4e63a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.624-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6db227d69dbae478c0b94da5ebea81f253447c753183951a39ad14be2f0e38d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.624-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06b1357374e34c3beb2891c2b6385409f18b9ce8a0338c553c8f3220916afa00"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.624-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59c30839aff19c3cb725b7d95898f4191bdbbd30c25694ad26af44d142a68875"
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
