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
  version "0.5.912-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.912-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c65efedf871246ca95361cb3d9b30b9f430ef7f325ff4eda93d510edbd0c0b83"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.912-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bc8055f68e5f739ab703f76ded783e2f64aad434dd35865556d74e2e8ae58167"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.912-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d8de7b34056711b0609eb9735f6cbdec5693b71b17a8911cea3cca1eac1907cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.912-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a5f9035006105c001b85cfad8f75cb0332ae3633b34558a3cf702c4fe6c068a4"
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
