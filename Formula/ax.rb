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
  version "0.5.1092-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1092-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a57e55f2527b47551b34733947a4e418da86d56569848e3d0ba153eb2b10f707"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1092-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b606989f04c36857f5c43b531e9f727f52700110cdddeb19e55bfc15a3573d8e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1092-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "774e98842a34c42219e78334ee51c7754af20d60c4e98b1c59872e693c95a60f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1092-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f27a3b66626a8a4e2cffbb4b954d26a193dd79f6ad693fb52a69d2fc2b07e819"
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
