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
  version "0.5.708-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.708-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9bcddac7b940ab4e944e0a0e7db4111f474bd529721795830f669bc999607e15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.708-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f8f698765bf18a0a5a236e284fd183a4be0a22ec14ea4ef02dccb88bb2320d57"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.708-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8ad34266a7a0ed9f190d87f193e625844d4633dcfdadcfd85825671f38e095b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.708-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b20b94b212342a67b9421daaaccd4944f97f83b5b836435fe9e2c5dd56d2ffd1"
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
