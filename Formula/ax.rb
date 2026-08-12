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
  version "0.5.745-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.745-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "47fa5c0b75bd86f9bfca3a49558249d5b494c470320eb77f09ca29ae75250a24"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.745-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "92a48c5a2251da62ed8521bc23ecaa04f30992be81d288a8c592e46de0638c22"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.745-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "121ba9b3278bf34b2cd4fe0b67d72b094027cb568ba880e1a0e73e05db973370"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.745-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a5b5b535de183d77c4d04834a3fedf63810ba9581f16a11b75dadf8924ff95f5"
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
