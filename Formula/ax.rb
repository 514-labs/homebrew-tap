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
  version "0.5.1115-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1115-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "09ac9856252a3296e63f6dfe233fa60350508b2a518c6b52f5534c5ae5a2a993"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1115-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b2ea22c4dd5e4da8a8e24cf79a380435a414f93578ea8b6c3857893e9213738c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1115-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f73796a2136941b2a6b7d4149d66f0d9c5b69cef9f7eeaf34abd1fe47e2fb09b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1115-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fd226c6d768b2d608dda01c37401f75a6fd2e55fffcc7f23d1cdc48777ca5904"
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
