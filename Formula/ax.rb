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
  version "0.5.370-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.370-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "405ec5ec40e24cc9f443468a1df2158de3788946ab06a87f3ddccc452c9e6daa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.370-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c200849c39a53f833adb15cc9fadefe51f2e62eeb8d1e325c6f2454b94001d03"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.370-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "945fe21c643bbe5830b96d42a34bcc830e74da00b89418d91dee4db7eb696fb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.370-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "573a5a3133a3c746e02edd7d4d0d50dbbf6e9c8b9f32f6fa2cd796c1e09c8fab"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
