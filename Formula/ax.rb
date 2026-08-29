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
  version "0.5.929-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.929-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b120ca3c871a04f846b97d904c488aa23b3b2aa06226e10da3b786d78068f70b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.929-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f0adc2190a8f06c63369965eb24c97710dbcbc6343f47e4ea01c8ca92a56d938"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.929-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f3aa654a23104e056f31e2e3e854ea1dcf03732d3d0353e651bc9b23bb290a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.929-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f247cc31fae24958a7db291fa27b9d6e34be8556da8de44478f03d6e8123fb7"
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
