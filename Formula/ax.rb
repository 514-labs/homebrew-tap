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
  version "0.5.711-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.711-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6178f3a1f29a32c73c6c231e16ac01a99a09770f768185db2954c12b02828584"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.711-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3727a4113981ac3af092be7d7db97cf3c784c807e2251d4d2bf9f9f85321b524"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.711-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b88d7f039ce934709b45b0b5f32f460dcbea9026c50f1bf4dffed8334a07d871"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.711-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0cdc6891b98f2d902448687fc33697884194eb240f180c79d75d339ca13e255c"
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
