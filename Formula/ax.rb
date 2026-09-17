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
  version "0.5.1063-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1063-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5142654fc1298ff61b49fe9a2380b2600488af2f8133baf0f7ca2f7368418086"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1063-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f88a379f6cd1711eabf7189ce61d8b838dfd9754ec547b10668d2f5d52e98a1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1063-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01410669e43d30bf978fc1ba3cbf0a8385c978542d6a8c0957d58e995d6151ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1063-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a82fe9a59546ef99836fae62aff83924e274677a79d8414ab02eb041b028f6f6"
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
