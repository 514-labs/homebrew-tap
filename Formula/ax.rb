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
  version "0.5.672-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.672-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a9e1344a34c88724a31e1a8f51c881c7f9db637ffd00013ce48e4e4532f96fc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.672-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9b0baebbaf3ecedd4e521b7837d74cc9b184c6b29634e29c3a41576fb6c97153"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.672-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1bac5eb90b03ee450b530fdafe82e66a8b524cf79d1278b30e852cec451b78b5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.672-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe549a1f2f9fcaeb12dcc4c76cc8c8ee87347fd80b1a24d1b0d33c9cdd064279"
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
