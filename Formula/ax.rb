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
  version "0.5.813-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.813-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "23916cf781fd5f8449be7f4f4393e1aaaa0c01b780dfb61aeb445658f9f79650"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.813-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2607525f7838d6d620ed38e34ffcc856bff07f656c8454c3281b7c188a0253b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.813-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bcef469ada5a1a0a712c71f9106f89c4d67aa336e58e58493d89df46a6c6922d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.813-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "48f98e7276b5fab192bfc911704c876da5400c7786c39812e47594fc531198c4"
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
