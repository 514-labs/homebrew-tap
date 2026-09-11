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
  version "0.5.1027-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1027-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bcb56bb8bd237e9a1aa6423099b105241c816d1256f9e4d7d8bd79db0d010eb2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1027-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ac388a77557da28e93ff8d6a35ce1b2586109c22d60cd7f27dae35867f8bf2b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1027-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91aa3c11ab24c47b2c454dc0119f860c8f770bdd22b4b425db1de70fcb31732e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1027-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4a4bdd68ca35ff6ab5cb90b89a39ca7f0a55af00d48065b1291de2f7d9512567"
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
