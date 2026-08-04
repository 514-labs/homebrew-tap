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
  version "0.5.650-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.650-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a52bbb61e6f98c28cd1be06e94c740ffef0a7bcb56dd118e597b31be6a7cde19"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.650-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2c60c154ed22831a4ffa6a7ee5a6c17a899381d8f1f40b9ed133638750bcd2bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.650-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e4451fc2513fe2b646b0d78dfb8768ce7d3525b1065497303ade35ec82ee5bbb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.650-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9eca8b67ae8492a57d742cdf9d6fa4291a4a45595d68d35b380187b9fd45f2ab"
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
