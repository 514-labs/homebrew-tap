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
  version "0.5.667-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.667-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "62582de6e0dc2da36161f212008ccdd0452a21b9ecd2aa1cc837a56dc0b63eda"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.667-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a164c2298b555cd5ca0f09c19575f21345725fc5977221589d5009460403532e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.667-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4283cb3c880758f1e8b2a90d875f3c6f52f8ee9cef014488fb814fc1b1bfc27e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.667-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "17bf3ae7b6895ea16ee8c5eeeffdde888a18affd3690deedd537987712879116"
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
