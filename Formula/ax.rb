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
  version "0.5.1169-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1169-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "29277b4303f08ce25bc6aa863cba15dcddd825969ded843fb9729e9b5bad025a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1169-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bfe68c26f2bd7bd629c429fad0b9cba4e2873c0a5656bb6a6eaca4af8040ef8f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1169-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e4dca1765f0b0527c85eed6f0fb5cf94c6b3dd0b7d0382bb1f6636f09c3c5338"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1169-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1a2e6310884efefb25cb4f4462e20058d063ee330836d03e7213fe01065bcb17"
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
