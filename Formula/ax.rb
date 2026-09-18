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
  version "0.5.1071-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1071-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a69eb0b7dc8a345837c3e3f32746c06d093677504592aa4875f2c1674b7810e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1071-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b6791002208f9d31eb89d8a31a0960960735816083c805615f326296a9bc2288"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1071-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b06d95e20522a6f65e6504346b1ae54b0013266310c31f4c722c5f684a746cdf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1071-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b1876b95337d626ca5fd14558010b50db503efb2903811937e42cbbf759dde9f"
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
