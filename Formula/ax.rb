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
  version "0.5.802-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.802-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52aa7d4fb0a35250323cd3e208d164d22441af52cbb0458fb728cf3fbd12a67d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.802-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bcfc715dc391b4e3f27bd9289a96ffb016dff7709be542607f31f3e0398afb10"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.802-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a4e163e17b0646d98ee99e628b8f1e339efba3c0bc4fe42e9fece5bad45e6cd6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.802-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2911bd14d83b2172f2f6ce58d86c16dd3a391604508662aa06b9fd6db1871aff"
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
