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
  version "0.5.632-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.632-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f897a1754565ba520d7c5505715f08845d04d3157c7b846c5215be9f15212749"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.632-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f499b279513f5b4f17aef7d79a435ae7cfe1ab123d1d9dd429a1f1d937f189db"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.632-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5ee90eeba1ef6ad5c3732d8ae342f18abb2607125ed84075304c51cf7cd47aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.632-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cf9d2a017a01a1c028c6548240481badd4b21baca9666793f8c8cd8af4ab0a77"
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
