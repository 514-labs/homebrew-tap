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
  version "0.5.973-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.973-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dfdda2a6060f48de9edc419a1a554412f96a4bf9fa5cce290c880d6550cd7f11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.973-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "caf953e00e20cea887d5651f927a6addf320f2bb20fabbc9c929a863972e1ed6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.973-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5e9b768734bb29ab47145b00feacdd03fdddbaebf7a41750abb8de0b1fbada6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.973-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "730fab1cbf1f41a107a21bdcf8c1b8b4feddc73daf7cf7d6a7c1e3956fe10516"
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
