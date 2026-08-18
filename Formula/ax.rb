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
  version "0.5.821-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.821-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e2b4a9fec5a96fcffe60e5216f5cb310b6385952ae529ee1b2eda3f923e1b31c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.821-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "386cc3dc85b0b2c026f0c6ab1eb6e6ad1be98ad132e487fc6003866b720aa4c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.821-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4ff79d2327d8ee95a3c9a55a9282b01932b238d133a06a7d46065cdd6923d6d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.821-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3c0f4bf22b5b164bdfccdd690f3a113e9d3ab978ae88f72e4d9444a248d1da46"
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
