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
  version "0.5.945-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.945-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2994b9d6e867ae123c33cca60ecc2f84369d107aa604d4a744715309b8ae5dc1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.945-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dbf4e9be1b2e9567d76f31aa27b9e12b46dd9eafe300c889ed712bfd9548ac0d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.945-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8f9c00ae7c9c7819f9e9392f6cb8605b5ec13cdf55f90edb400ed3b44e453858"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.945-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "958f25b66c6ee5aab4be0dbafd0e51d886eab2f6a21030b98f990f2e3fa5920a"
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
