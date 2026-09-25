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
  version "0.5.1137-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1137-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d42050a2851e2047e575bbc97c0a51f6d060f59d683172d45928849a86420506"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1137-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "051d6069cab757a0e8a2a5ae9345e00bdf8dd7203ec38cfef95e05c0377e4b49"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1137-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5683ef4d8c472d3ef4317d010e6d9ef7a6db204e676fe7aa6828b6f403ab0870"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1137-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87a888b0f48c7b5837a63dea5c37caaab4892adee539610a787c488e9a26dc72"
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
