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
  version "0.5.750-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.750-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ebc562ea42400b02eb6293ef971c1c39ca4ddf962bbe2e38033b520cc2265b4e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.750-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2d59586dd7594f16c3f90bcc3db6ece397f38e160dc5ce07c13de8bcaeb52810"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.750-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97d341fa07c72252a8359690955b0addfd268d9f0535b1525d8e604bbc03ae49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.750-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "00512849ecf5b00e154852a2f44dc6d174983df8fb378f1aab7cf22abf6f642f"
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
