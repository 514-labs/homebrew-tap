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
  version "0.5.797-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.797-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9555d642b644f40aac709b9506e69d3ccdf1e8a4c2ca414b2457bf2645316dd9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.797-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4021a5669cee683b73028a15f2634468a70393fa002dccb29fa239823cdc75a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.797-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec7edca838194a96b39c966af4cb9e7c0a2ed48cb8e911babd22c9cb3653591b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.797-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "290dabb66d69833cb532aff1cbb4610ec23dc4a8d893bc26e19252435ee638e4"
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
