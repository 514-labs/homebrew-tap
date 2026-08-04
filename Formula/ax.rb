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
  version "0.5.646-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.646-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2cf409c58d9b9d3b3a3f24d019790f99b2304e6a9bf8a0244fcd0ec2bcc7c844"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.646-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "92a3273ae5c8a5b2d12f288c76a7a7c431085c05ad82afec2beabcd8b0a81c46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.646-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0f1037a9de049619b88020fddaa73938e8e52dc3885c805e5627ad06362cbf3b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.646-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9d233b4ec7f0f4f44478480287476cee09e6789cda522daeed4f4ed8631e694"
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
