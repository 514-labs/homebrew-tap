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
  version "0.5.1016-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1016-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ae94890f7f9c56da70af9c16c865f78af6a04dfe92052c917fa9a7b1bc54b4e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1016-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "91ef3453990a470f53f9d00acaeecb47d381a791ca504f5ce81344a37b537762"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1016-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a16ea70ee4ca00afa0332844baa45815b5b535c3283adde5a99f33630401ebcf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1016-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58aaa802c7187cfffc8cb7b56d5cea106130c5bcbb8d5b0131d435812e879cf1"
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
