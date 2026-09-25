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
  version "0.5.1133-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1133-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c8a8c2c39816d3ea03b33160c08a1b06a2854498b66db1123e57dc75dc02b418"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1133-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0511233340151063c9586016308323f0e61ce7ead091ef7b6fc3ca324e61b93e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1133-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26feab20eb3dc99280109695e687b1d0a02bb951daae294f162bc49a6f05a20b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1133-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "da089cb213cda43e186cbd42eb2a8988dbf1fb708267744ab0651af11f890207"
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
