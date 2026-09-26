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
  version "0.5.1148-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1148-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5f547c131811ff9dc1dc820670072257ea1fc6051f92e7d9c02738b27df2d4eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1148-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c88c24a75b9e6cf9f3dd63f5d3b151031b4a44092b093a8a774050f29c785a49"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1148-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d17b182e4d6d4462275bc87db98aa56a3b57244e5eb5c5585fa901b0a0621879"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1148-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fd6e9cbe27cc7a1e761a30394a7fc8663600b3fa1af82347c64750d29a5e958b"
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
