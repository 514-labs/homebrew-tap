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
  version "0.5.1013-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1013-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b358389b1abf4c5e564fb032a172ee33b9213b6d94fb11bff2e1cb8f30a1b7c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1013-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "abec186607f5f92c2255b5b37284c27d7d055ea6374aef9e9f944a0990e61722"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1013-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d377297ea5ca0bbf358e7470e8fd0bfadc69c4b20f3ba2ff0da425079c989ac5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1013-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2e9b09a50f682465176b1b447fec3a3f7b6ebca0859620141517cb22662bdac"
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
